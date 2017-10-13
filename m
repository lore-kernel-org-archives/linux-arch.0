Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751632AbdJMQMf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Oct 2017 12:12:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9DG5E4g106636
        for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2017 12:12:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2djwejj0xa-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2017 12:12:34 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 13 Oct 2017 12:12:33 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/sched/membarrier 2/5] membarrier: selftest: Test private expedited cmd
Date: Fri, 13 Oct 2017 09:12:22 -0700
In-Reply-To: <20171012170051.GA27468@linux.vnet.ibm.com>
References: <20171012170051.GA27468@linux.vnet.ibm.com>
Message-ID: <1507911145-4134-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, viro@zeniv.linux.org.uk, piggin@gmail.com, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alice Ferrazzi <alice.ferrazzi@gmail.com>, Paul Elder <paul.elder@pitt.edu>, linux-kselftest@vger.kernel.org
Message-ID: <20171013161222.sKr4z0BMx19s4Er35hLU0FuJub6vDKGXpUkaqD3uuhw@z>

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Test the new MEMBARRIER_CMD_PRIVATE_EXPEDITED and
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED commands.

Add checks expecting specific error values on system calls expected to
fail.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: gromer@google.com
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Alan Stern <stern@rowland.harvard.edu>
CC: Will Deacon <will.deacon@arm.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Alice Ferrazzi <alice.ferrazzi@gmail.com>
CC: Paul Elder <paul.elder@pitt.edu>
CC: linux-kselftest@vger.kernel.org
CC: linux-arch@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../testing/selftests/membarrier/membarrier_test.c | 109 ++++++++++++++++++---
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 21399fcf1a59..f85657374b59 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -15,49 +15,119 @@ static int sys_membarrier(int cmd, int flags)
 static int test_membarrier_cmd_fail(void)
 {
 	int cmd = -1, flags = 0;
+	const char *test_name = "sys membarrier invalid command";
 
 	if (sys_membarrier(cmd, flags) != -1) {
 		ksft_exit_fail_msg(
-			"sys membarrier invalid command test: command = %d, flags = %d. Should fail, but passed\n",
-			cmd, flags);
+			"%s test: command = %d, flags = %d. Should fail, but passed\n",
+			test_name, cmd, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier invalid command test: command = %d, flags = %d. Failed as expected\n",
-		cmd, flags);
+		"%s test: command = %d, flags = %d, errno = %d. Failed as expected\n",
+		test_name, cmd, flags, errno);
 	return 0;
 }
 
 static int test_membarrier_flags_fail(void)
 {
 	int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid flags";
 
 	if (sys_membarrier(cmd, flags) != -1) {
 		ksft_exit_fail_msg(
-			"sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags = %d. Should fail, but passed\n",
-			flags);
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EINVAL) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EINVAL, strerror(EINVAL),
+			errno, strerror(errno));
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags = %d. Failed as expected\n",
-		flags);
+		"%s test: flags = %d, errno = %d. Failed as expected\n",
+		test_name, flags, errno);
 	return 0;
 }
 
-static int test_membarrier_success(void)
+static int test_membarrier_shared_success(void)
 {
 	int cmd = MEMBARRIER_CMD_SHARED, flags = 0;
-	const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED\n";
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n", test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_fail(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failure";
+
+	if (sys_membarrier(cmd, flags) != -1) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should fail, but passed\n",
+			test_name, flags);
+	}
+	if (errno != EPERM) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d. Should return (%d: \"%s\"), but returned (%d: \"%s\").\n",
+			test_name, flags, EPERM, strerror(EPERM),
+			errno, strerror(errno));
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d, errno = %d\n",
+		test_name, flags, errno);
+	return 0;
+}
+
+static int test_membarrier_register_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
 
 	if (sys_membarrier(cmd, flags) != 0) {
 		ksft_exit_fail_msg(
-			"sys membarrier MEMBARRIER_CMD_SHARED test: flags = %d\n",
-			flags);
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
 	}
 
 	ksft_test_result_pass(
-		"sys membarrier MEMBARRIER_CMD_SHARED test: flags = %d\n",
-		flags);
+		"%s test: flags = %d\n",
+		test_name, flags);
+	return 0;
+}
+
+static int test_membarrier_private_expedited_success(void)
+{
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED";
+
+	if (sys_membarrier(cmd, flags) != 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	}
+
+	ksft_test_result_pass(
+		"%s test: flags = %d\n",
+		test_name, flags);
 	return 0;
 }
 
@@ -71,7 +141,16 @@ static int test_membarrier(void)
 	status = test_membarrier_flags_fail();
 	if (status)
 		return status;
-	status = test_membarrier_success();
+	status = test_membarrier_shared_success();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_fail();
+	if (status)
+		return status;
+	status = test_membarrier_register_private_expedited_success();
+	if (status)
+		return status;
+	status = test_membarrier_private_expedited_success();
 	if (status)
 		return status;
 	return 0;
-- 
2.5.2
