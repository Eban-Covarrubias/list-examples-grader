CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

file_path="student-submission/ListExamples.java"
class_name="ListExamples"
method1="filter"
method2="merge"
if [ -e "$file_path" ]; then
    echo "Java file '$file_path' exists."
    #java "${file_path%.java}"  # Execute the compiled Java class
    if grep -q "class $class_name\b" "$file_path"; then
        echo "The class $class_name exists in $file_path."
        if grep -q "$method1" "$file_path"; then
            echo "$method1 exists in class $class_name in $file_path."
        else
            echo "$method1 doesn't exist in class $class_name in $file_path."
        fi
        if grep -q "$method2" "$file_path"; then
            echo "$method2 exists in class $class_name in $file_path."
        else
            echo "$method2 doesn't exist in class $class_name in $file_path."
        fi

    else
        echo "The class $class_name does not exist in $file_path."
    fi

else
    echo "Java file '$file_path' does not exist."
fi

cp -r $file_path grading-area
javac -cp "$CPATH" TestListExamples.java grading-area/ListExamples.java
if [[ $? -eq 0 ]]; then
    echo "the files compiled"
else
    echo "the files did not compile"
fi

java TestListExamples grading-area/ListExamples 
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
