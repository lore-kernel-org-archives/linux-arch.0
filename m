Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751234AbdJDViG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2017 17:38:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v94LaQtU126464
        for <linux-arch@vger.kernel.org>; Wed, 4 Oct 2017 17:38:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dd5ekeknp-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 04 Oct 2017 17:38:05 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 4 Oct 2017 17:38:04 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/3] membarrier: selftest: Test private expedited cmd
Date: Wed,  4 Oct 2017 14:37:54 -0700
In-Reply-To: <20171004213734.GA11463@linux.vnet.ibm.com>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
Message-ID: <1507153075-12345-2-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Alice Ferrazzi <alice.ferrazzi@gmail.com>, Paul Elder <paul.elder@pitt.edu>, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20171004213754.cGOjc53qdwB6K-_NVWNxAO9AIiBTm4lIUmLjmMEouHQ@z>

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
