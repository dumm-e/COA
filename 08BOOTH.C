#include <stdio.h>
#include <math.h>

int a = 0, b = 0, c = 0, a1 = 0, b1 = 0;
int com[5] = {1, 0, 0, 0, 0};
int anum[5] = {0}, anumcp[5] = {0}, bnum[5] = {0};
int acomp[5] = {0}, bcomp[5] = {0}, pro[5] = {0}, res[5] = {0};

void binary()
{
    a1 = fabs(a);
    b1 = fabs(b);
    int r, r2, i;
    for (i = 0; i < 5; i++) {
        r = a1 % 2;
        a1 = a1 / 2;
        r2 = b1 % 2;
        b1 = b1 / 2;
        anum[i] = r;
        anumcp[i] = r;
        bnum[i] = r2;
        bcomp[i] = (r2 == 0) ? 1 : 0;
        acomp[i] = (r == 0) ? 1 : 0;
    }
    c = 0;
    for (i = 0; i < 5; i++) {
        res[i] = com[i] + bcomp[i] + c;
        c = (res[i] >= 2) ? 1 : 0;
        res[i] = res[i] % 2;
    }
    for (i = 4; i >= 0; i--) {
        bcomp[i] = res[i];
    }
    if (a < 0) {
        c = 0;
        for (i = 0; i < 5; i++) {
            res[i] = com[i] + acomp[i] + c;
            c = (res[i] >= 2) ? 1 : 0;
            res[i] = res[i] % 2;
        }
        for (i = 4; i >= 0; i--) {
            anum[i] = res[i];
            anumcp[i] = res[i];
        }
    }
    if (b < 0) {
        int temp;
        for (i = 0; i < 5; i++) {
            temp = bnum[i];
            bnum[i] = bcomp[i];
            bcomp[i] = temp;
        }
    }
}

void add(int num[])
{
    int i;
    c = 0;
    for (i = 0; i < 5; i++) {
        res[i] = pro[i] + num[i] + c;
        c = (res[i] >= 2) ? 1 : 0;
        res[i] = res[i] % 2;
    }
    for (i = 4; i >= 0; i--) {
        pro[i] = res[i];
        printf("%d", pro[i]);
    }
    printf(":");
    for (i = 4; i >= 0; i--) {
        printf("%d", anumcp[i]);
    }
}

void main()
{
    int i, q = 0, temp, temp2;
    printf("\t\tBOOTH'S MULTIPLICATION ALGORITHM\n");
    printf("Enter two numbers to multiply (both must be less than 16): ");
    do {
        printf("\nEnter A: ");
        scanf("%d", &a);
        printf("Enter B: ");
        scanf("%d", &b);
    } while (a >= 16 || b >= 16);
    printf("\nExpected product = %d", a * b);
    binary();
    printf("\n\nBinary Equivalents are:\n");
    printf("A = ");
    for (i = 4; i >= 0; i--) {
        printf("%d", anum[i]);
    }
    printf("\nB = ");
    for (i = 4; i >= 0; i--) {
        printf("%d", bnum[i]);
    }
    printf("\nB' + 1 = ");
    for (i = 4; i >= 0; i--) {
        printf("%d", bcomp[i]);
    }
    printf("\n\n");
    for (i = 0; i < 5; i++) {
        int isEqual = (anum[i] == q);
        int isSubtract = (anum[i] == 1 && q == 0);
        printf("\n-->");
        temp = pro[4];
        temp2 = pro[0];
        for (int j = 1; j < 5; j++) {
            pro[j - 1] = pro[j];
        }
        pro[4] = temp;
        for (int j = 1; j < 5; j++) {
            anumcp[j - 1] = anumcp[j];
        }
        anumcp[4] = temp2;
        printf("\nAR-SHIFT: ");
        for (int j = 4; j >= 0; j--) {
            printf("%d", pro[j]);
        }
        printf(":");
        for (int j = 4; j >= 0; j--) {
            printf("%d", anumcp[j]);
        }
        if (isSubtract) {
            printf("\nSUB B: ");
            add(bcomp);
        } else {
            printf("\nADD B: ");
            add(bnum);
        }
        temp = pro[4];
        temp2 = pro[0];
        for (int j = 1; j < 5; j++) {
            pro[j - 1] = pro[j];
        }
        pro[4] = temp;
        for (int j = 1; j < 5; j++) {
            anumcp[j - 1] = anumcp[j];
        }
        anumcp[4] = temp2;
        printf("\nAR-SHIFT: ");
        for (int j = 4; j >= 0; j--) {
            printf("%d", pro[j]);
        }
        printf(":");
        for (int j = 4; j >= 0; j--) {
            printf("%d", anumcp[j]);
        }
        q = anum[i];
    }
    printf("\nProduct is = ");
    for (i = 4; i >= 0; i--) {
        printf("%d", pro[i]);
    }
    for (i = 4; i >= 0; i--) {
        printf("%d", anumcp[i]);
    }
}
