# Lab 2: ALU Transcript Generator

A Python program that works out a student's final standing from a CSV of
course grades, plus a Bash script that archives the grades file.

## Files

| File | Purpose |
|---|---|
| `grade-evaluator.py` | Validates grades and weights, calculates the GPA, decides PASSED or FAILED and lists what to resubmit |
| `organizer.sh` | Archives `grades.csv` with a timestamp and logs the action |
| `grades.csv` | Sample course data (`assignment,group,score,weight`) |

## grade-evaluator.py

```
python3 grade-evaluator.py
Enter the name of the CSV file to process (e.g., grades.csv): grades.csv
```

What it does, in order:

1. **Grade validation.** Every score must be between 0 and 100.
2. **Weight validation.** All weights must add up to exactly 100, the
   Summative weights to 40 and the Formative weights to 60.
3. **GPA.** Total Grade is the sum of `score x weight / 100`.
   `GPA = (Total Grade / 100) x 5.0`.
4. **Final decision.** PASSED only when the student scores at least 50% in
   both the Formative and the Summative category. A category's percentage is
   the points earned in it divided by the weight of the category.
5. **Resubmission.** Among formative assignments scored below 50, the one with
   the highest weight is eligible. If several share that weight, all of them
   are listed.

If validation fails, the program prints what is wrong and exits with status 1.

### Sample result for the provided `grades.csv`

```
Formative: 34.00 / 60 (56.67%)
Summative: 26.00 / 40 (65.00%)

Total Grade: 60.00 / 100
GPA: 3.00
Final Status: PASSED

Eligible for resubmission (highest weight among failed formative assignments, weight 20):
  - Group Exercise (score 40%)
  - Functions and Debugging Lab (score 45%)
```

## organizer.sh

```
chmod +x organizer.sh
./organizer.sh
```

1. Creates the `archive/` directory if it does not exist.
2. Renames `grades.csv` to `grades_<YYYYMMDD-HHMMSS>.csv` and moves it into
   `archive/`.
3. Creates a new, empty `grades.csv` ready for the next batch.
4. Appends a line to `organizer.log` with the timestamp, the original file
   name and the archived file name. The log keeps every run.

If there is no `grades.csv`, it prints an error and exits with status 1.

On Windows, run it from Git Bash or WSL.

## Testing

I checked the calculations by hand and ran the program on edge cases:
scores above 100, weights that do not add up, an unknown group, an empty
file, a missing file, no failed formative assignments, a single highest
weight, tied highest weights, and a category sitting exactly at 50%.
