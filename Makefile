CXX = 		g++ -std=c++0x

CXXFLAGS =	-O2 -g -Wall -fmessage-length=0

LDFLAGS = 	-shared  # linking flags

SRCDIR	=	src

INCDIR	=	include

OBJDIR	=	obj

EXEDIR	=	exe

DIR_GUARD =	@mkdir -p $(@D)

UTLSRCDIR =	$(SRCDIR)/utils

UTLINCDIR = $(INCDIR)/utils

UTLOBJDIR = $(OBJDIR)/utils

MATSRCDIR =	$(SRCDIR)/matrix

MATINCDIR = $(INCDIR)/matrix

MATOBJDIR = $(OBJDIR)/matrix

VECSRCDIR =	$(SRCDIR)/vector

VECINCDIR = $(INCDIR)/vector

VECOBJDIR = $(OBJDIR)/vector

DECSRCDIR =	$(SRCDIR)/decomposition

DECINCDIR = $(INCDIR)/decomposition

DECOBJDIR = $(OBJDIR)/decomposition

IOOBJDIR = $(OBJDIR)/io

IOSRCDIR =	$(SRCDIR)/io

IOINCDIR = $(INCDIR)/io

CLASRCDIR =	$(SRCDIR)/classification

CLAINCDIR = $(INCDIR)/classification

CLAOBJDIR = $(OBJDIR)/classification

OPTSRCDIR =	$(SRCDIR)/optimization

OPTINCDIR = $(INCDIR)/optimization

OPTOBJDIR = $(OBJDIR)/optimization

KERSRCDIR =	$(SRCDIR)/kernel

KERINCDIR = $(INCDIR)/kernel

KEROBJDIR = $(OBJDIR)/kernel

MANSRCDIR =	$(SRCDIR)/manifold

MANINCDIR = $(INCDIR)/manifold

MANOBJDIR = $(OBJDIR)/manifold

CLUSRCDIR =	$(SRCDIR)/clustering

CLUINCDIR = $(INCDIR)/clustering

CLUOBJDIR = $(OBJDIR)/clustering

REGSRCDIR =	$(SRCDIR)/regression

REGINCDIR = $(INCDIR)/regression

REGOBJDIR = $(OBJDIR)/regression

RANSRCDIR =	$(SRCDIR)/random

RANINCDIR = $(INCDIR)/random

RANOBJDIR = $(OBJDIR)/random

RECSRCDIR =	$(SRCDIR)/recovery

RECINCDIR = $(INCDIR)/recovery

RECOBJDIR = $(OBJDIR)/recovery

SEQSRCDIR =	$(SRCDIR)/sequence

SEQINCDIR = $(INCDIR)/sequence

SEQOBJDIR = $(OBJDIR)/sequence

LIBS 	=	

INCS	=	-I $(MATINCDIR) -I $(VECINCDIR) -I $(UTLINCDIR) -I $(DECINCDIR) \
			-I $(IOINCDIR) -I $(CLAINCDIR) -I $(OPTINCDIR) -I $(KERINCDIR) \
			-I $(MANINCDIR) -I $(CLUINCDIR) -I $(REGINCDIR) -I $(RANINCDIR) \
			-I $(RECINCDIR) -I $(SEQINCDIR)

UTLOBJS =	$(UTLOBJDIR)/Utility.o $(UTLOBJDIR)/Time.o $(UTLOBJDIR)/Printer.o \
			$(UTLOBJDIR)/Matlab.o $(UTLOBJDIR)/ArrayOperator.o $(UTLOBJDIR)/InPlaceOperator.o \
			$(UTLOBJDIR)/Options.o

MATOBJS =	$(MATOBJDIR)/DenseMatrix.o $(MATOBJDIR)/SparseMatrix.o

VECOBJS	=	$(VECOBJDIR)/DenseVector.o $(VECOBJDIR)/SparseVector.o

DECOBJS =	$(DECOBJDIR)/LU.o $(DECOBJDIR)/QR.o $(DECOBJDIR)/SVD.o $(DECOBJDIR)/EVD.o

IOOBJS	=	$(IOOBJDIR)/IO.o $(IOOBJDIR)/DataSet.o

CLAOBJS	=	$(CLAOBJDIR)/Classifier.o $(CLAOBJDIR)/LinearBinarySVM.o $(CLAOBJDIR)/LinearMCSVM.o \
			$(CLAOBJDIR)/LogisticRegression.o $(CLAOBJDIR)/LogisticRegressionByNonnegativePLBFGS.o \
			$(CLAOBJDIR)/LogisticRegressionByNonlinearConjugateGradient.o

OPTOBJS	=	$(OPTOBJDIR)/LBFGS.o $(OPTOBJDIR)/LBFGSForVector.o $(OPTOBJDIR)/NonnegativePLBFGS.o \
			$(OPTOBJDIR)/GeneralQP.o $(OPTOBJDIR)/ProximalMapping.o $(OPTOBJDIR)/Projection.o \
			$(OPTOBJDIR)/AcceleratedProximalGradient.o $(OPTOBJDIR)/AcceleratedGradientDescent.o \
			$(OPTOBJDIR)/NonlinearConjugateGradient.o
			
KEROBJS	=	$(KEROBJDIR)/Kernel.o

MANOBJS	=	$(MANOBJDIR)/Manifold.o

CLUOBJS	=	$(CLUOBJDIR)/Clustering.o $(CLUOBJDIR)/KMeans.o $(CLUOBJDIR)/L1NMF.o $(CLUOBJDIR)/NMF.o \
			$(CLUOBJDIR)/SpectralClustering.o
			
REGOBJS	=	$(REGOBJDIR)/Regression.o $(REGOBJDIR)/LASSO.o

RANOBJS	=	$(RANOBJDIR)/Distribution.o

RECOBJS	=	$(RECOBJDIR)/RobustPCA.o $(RECOBJDIR)/MatrixCompletion.o

SEQOBJS	=	$(SEQOBJDIR)/CRF.o $(SEQOBJDIR)/HMM.o

ALLOBJS	=	$(UTLOBJS) $(MATOBJS) $(VECOBJS) $(DECOBJS) $(IOOBJS) $(CLAOBJS) $(OPTOBJS) \
			$(KEROBJS) $(MANOBJS) $(CLUOBJS) $(REGOBJS) $(RANOBJS) $(RECOBJS) $(SEQOBJS)

ALLTEST	=	LAMLTest MatrixTest VectorTest LUTest QRTest SVDTest EVDTest IOTest DataSetTest \
			SVMTest MCSVMTest LRTest LRNPLBFGSTest QPTest APGTest AGDTest LRNCGTest \
			ManifoldTest KMeansTest L1NMFTest NMFTest SpecClusTest LASSOTest MVNRNDTest \
			RPCATest MCTest CRFTest

TARGET 	=	libLAML.a
SHALIB	=	libLAML.so

all:	$(ALLOBJS)
	ar rcs $(TARGET) $(ALLOBJS)
	$(CXX) $(LDFLAGS) -o $(SHALIB) $^
	
AllTest:	$(ALLTEST)

#------------------------------------------------------------------------------------------
# All Test Programs

%Test:	$(SRCDIR)/%Test.cpp $(ALLOBJS)
	@mkdir -p $(EXEDIR)
	$(CXX) $(CXXFLAGS) $(ALLOBJS) $< -o $(EXEDIR)/$@.exe $(INCS)
	
#------------------------------------------------------------------------------------------
# Utility Package

$(UTLOBJDIR)/Time.o:	$(UTLSRCDIR)/Time.cpp $(UTLINCDIR)/MyTime.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
$(UTLOBJDIR)/%.o: $(UTLSRCDIR)/%.cpp $(UTLINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Matrix Package

$(MATOBJDIR)/DenseMatrix.o: $(MATSRCDIR)/DenseMatrix.cpp $(MATINCDIR)/DenseMatrix.h $(MATINCDIR)/Matrix.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
$(MATOBJDIR)/SparseMatrix.o: $(MATSRCDIR)/SparseMatrix.cpp $(MATINCDIR)/SparseMatrix.h $(MATINCDIR)/Matrix.h $(UTLOBJS) 
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Vector Package

$(VECOBJDIR)/DenseVector.o: $(VECSRCDIR)/DenseVector.cpp $(VECINCDIR)/DenseVector.h $(VECINCDIR)/Vector.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
$(VECOBJDIR)/SparseVector.o: $(VECSRCDIR)/SparseVector.cpp $(VECINCDIR)/SparseVector.h $(VECINCDIR)/Vector.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Decomposition Package

$(DECOBJDIR)/%.o: $(DECSRCDIR)/%.cpp $(DECINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# IO Package

$(IOOBJDIR)/%.o: $(IOSRCDIR)/%.cpp $(IOINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
#------------------------------------------------------------------------------------------
# Classification Package

$(CLAOBJDIR)/Classifier.o: $(CLASRCDIR)/Classifier.cpp $(CLAINCDIR)/Classifier.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

$(CLAOBJDIR)/%.o: $(CLASRCDIR)/%.cpp $(CLAINCDIR)/%.h $(CLAINCDIR)/Classifier.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
#------------------------------------------------------------------------------------------
# Optimization Package

$(OPTOBJDIR)/%.o: $(OPTSRCDIR)/%.cpp $(OPTINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Kernel Package

$(KEROBJDIR)/Kernel.o: $(KERSRCDIR)/Kernel.cpp $(KERINCDIR)/Kernel.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Manifold Package

$(MANOBJDIR)/%.o: $(MANSRCDIR)/%.cpp $(MANINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Clustering Package

$(CLUOBJDIR)/Clustering.o: $(CLUSRCDIR)/Clustering.cpp $(CLUINCDIR)/Clustering.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

$(CLUOBJDIR)/%.o: $(CLUSRCDIR)/%.cpp $(CLUINCDIR)/%.h $(CLUINCDIR)/Clustering.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
#------------------------------------------------------------------------------------------
# Regression Package

$(REGOBJDIR)/Regression.o: $(REGSRCDIR)/Regression.cpp $(REGINCDIR)/Regression.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

$(REGOBJDIR)/%.o: $(REGSRCDIR)/%.cpp $(REGINCDIR)/%.h $(REGINCDIR)/Regression.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)
	
#------------------------------------------------------------------------------------------
# Random Package

$(RANOBJDIR)/%.o: $(RANSRCDIR)/%.cpp $(RANINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Recovery Package

$(RECOBJDIR)/%.o: $(RECSRCDIR)/%.cpp $(RECINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Sequence Package

$(SEQOBJDIR)/%.o: $(SEQSRCDIR)/%.cpp $(SEQINCDIR)/%.h
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(INCS)

#------------------------------------------------------------------------------------------
# Clean All Output Files

clean:
	-rm -f $(ALLOBJS)
	-rm -rf $(OBJDIR)
	-rm -f $(TARGET)
	-rm -f $(SHALIB)
	-rm -f $(EXEDIR)/*.exe
	-rm -rf $(EXEDIR)
