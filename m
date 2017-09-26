From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH for 4.14 2/3] membarrier: selftest: Test private
 expedited cmd
Date: Tue, 26 Sep 2017 19:55:17 +0000 (UTC)
Message-ID: <1861482846.19234.1506455717905.JavaMail.zimbra@efficios.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com> <20170926175151.14264-2-mathieu.desnoyers@efficios.com> <CAKocOOPtzm+P-hbUAGDwpPMbPdrbQSpkJH-ideDvsD4-uUZepw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKocOOPtzm+P-hbUAGDwpPMbPdrbQSpkJH-ideDvsD4-uUZepw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuahkhan@gmail.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

----- On Sep 26, 2017, at 3:41 PM, Shuah Khan shuahkhan@gmail.com wrote:

> Hi Mathew,
> 
> On Tue, Sep 26, 2017 at 11:51 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>> Test the new MEMBARRIER_CMD_PRIVATE_EXPEDITED and
>> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED commands.
>>
>> Add checks expecting specific error values on system calls expected to
>> fail.
>>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: Andrew Hunter <ahh@google.com>
>> CC: Maged Michael <maged.michael@gmail.com>
>> CC: gromer@google.com
>> CC: Avi Kivity <avi@scylladb.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: Alan Stern <stern@rowland.harvard.edu>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Andy Lutomirski <luto@kernel.org>
>> CC: linux-arch@vger.kernel.org
>> ---
>>  .../testing/selftests/membarrier/membarrier_test.c | 109
> 
> Did you run get_maintainers script on this patch? I am curious why
> get_maintainers didn't include linux-kselftest@vger.kernel.org and
> shuah@kernel.org

My mistake. I'll add this script to my checklist before I send out
patches.

If OK with you, I can just add the ML in CC here.

Thanks,

Mathieu

> 
> thanks,
> -- Shuah
> 
> Please make sure you send the patches to
> ++++++++++++++++++---
>>  1 file changed, 94 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/membarrier/membarrier_test.c
>> b/tools/testing/selftests/membarrier/membarrier_test.c
>> index 21399fcf1a59..f85657374b59 100644
>> --- a/tools/testing/selftests/membarrier/membarrier_test.c
>> +++ b/tools/testing/selftests/membarrier/membarrier_test.c
>> @@ -15,49 +15,119 @@ static int sys_membarrier(int cmd, int flags)
>>  static int test_membarrier_cmd_fail(void)
>>  {
>>         int cmd = -1, flags = 0;
>> +       const char *test_name = "sys membarrier invalid command";
>>
>>         if (sys_membarrier(cmd, flags) != -1) {
>>                 ksft_exit_fail_msg(
>> -                       "sys membarrier invalid command test: command = %d,
>> flags = %d. Should fail, but passed\n",
>> -                       cmd, flags);
>> +                       "%s test: command = %d, flags = %d. Should fail, but
>> passed\n",
>> +                       test_name, cmd, flags);
>> +       }
>> +       if (errno != EINVAL) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d. Should return (%d: \"%s\"), but
>> returned (%d: \"%s\").\n",
>> +                       test_name, flags, EINVAL, strerror(EINVAL),
>> +                       errno, strerror(errno));
>>         }
>>
>>         ksft_test_result_pass(
>> -               "sys membarrier invalid command test: command = %d, flags = %d.
>> Failed as expected\n",
>> -               cmd, flags);
>> +               "%s test: command = %d, flags = %d, errno = %d. Failed as
>> expected\n",
>> +               test_name, cmd, flags, errno);
>>         return 0;
>>  }
>>
>>  static int test_membarrier_flags_fail(void)
>>  {
>>         int cmd = MEMBARRIER_CMD_QUERY, flags = 1;
>> +       const char *test_name = "sys membarrier MEMBARRIER_CMD_QUERY invalid
>> flags";
>>
>>         if (sys_membarrier(cmd, flags) != -1) {
>>                 ksft_exit_fail_msg(
>> -                       "sys membarrier MEMBARRIER_CMD_QUERY invalid flags test:
>> flags = %d. Should fail, but passed\n",
>> -                       flags);
>> +                       "%s test: flags = %d. Should fail, but passed\n",
>> +                       test_name, flags);
>> +       }
>> +       if (errno != EINVAL) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d. Should return (%d: \"%s\"), but
>> returned (%d: \"%s\").\n",
>> +                       test_name, flags, EINVAL, strerror(EINVAL),
>> +                       errno, strerror(errno));
>>         }
>>
>>         ksft_test_result_pass(
>> -               "sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =
>> %d. Failed as expected\n",
>> -               flags);
>> +               "%s test: flags = %d, errno = %d. Failed as expected\n",
>> +               test_name, flags, errno);
>>         return 0;
>>  }
>>
>> -static int test_membarrier_success(void)
>> +static int test_membarrier_shared_success(void)
>>  {
>>         int cmd = MEMBARRIER_CMD_SHARED, flags = 0;
>> -       const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED\n";
>> +       const char *test_name = "sys membarrier MEMBARRIER_CMD_SHARED";
>> +
>> +       if (sys_membarrier(cmd, flags) != 0) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d, errno = %d\n",
>> +                       test_name, flags, errno);
>> +       }
>> +
>> +       ksft_test_result_pass(
>> +               "%s test: flags = %d\n", test_name, flags);
>> +       return 0;
>> +}
>> +
>> +static int test_membarrier_private_expedited_fail(void)
>> +{
>> +       int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
>> +       const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED
>> not registered failure";
>> +
>> +       if (sys_membarrier(cmd, flags) != -1) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d. Should fail, but passed\n",
>> +                       test_name, flags);
>> +       }
>> +       if (errno != EPERM) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d. Should return (%d: \"%s\"), but
>> returned (%d: \"%s\").\n",
>> +                       test_name, flags, EPERM, strerror(EPERM),
>> +                       errno, strerror(errno));
>> +       }
>> +
>> +       ksft_test_result_pass(
>> +               "%s test: flags = %d, errno = %d\n",
>> +               test_name, flags, errno);
>> +       return 0;
>> +}
>> +
>> +static int test_membarrier_register_private_expedited_success(void)
>> +{
>> +       int cmd = MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED, flags = 0;
>> +       const char *test_name = "sys membarrier
>> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED";
>>
>>         if (sys_membarrier(cmd, flags) != 0) {
>>                 ksft_exit_fail_msg(
>> -                       "sys membarrier MEMBARRIER_CMD_SHARED test: flags =
>> %d\n",
>> -                       flags);
>> +                       "%s test: flags = %d, errno = %d\n",
>> +                       test_name, flags, errno);
>>         }
>>
>>         ksft_test_result_pass(
>> -               "sys membarrier MEMBARRIER_CMD_SHARED test: flags = %d\n",
>> -               flags);
>> +               "%s test: flags = %d\n",
>> +               test_name, flags);
>> +       return 0;
>> +}
>> +
>> +static int test_membarrier_private_expedited_success(void)
>> +{
>> +       int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
>> +       const char *test_name = "sys membarrier
>> MEMBARRIER_CMD_PRIVATE_EXPEDITED";
>> +
>> +       if (sys_membarrier(cmd, flags) != 0) {
>> +               ksft_exit_fail_msg(
>> +                       "%s test: flags = %d, errno = %d\n",
>> +                       test_name, flags, errno);
>> +       }
>> +
>> +       ksft_test_result_pass(
>> +               "%s test: flags = %d\n",
>> +               test_name, flags);
>>         return 0;
>>  }
>>
>> @@ -71,7 +141,16 @@ static int test_membarrier(void)
>>         status = test_membarrier_flags_fail();
>>         if (status)
>>                 return status;
>> -       status = test_membarrier_success();
>> +       status = test_membarrier_shared_success();
>> +       if (status)
>> +               return status;
>> +       status = test_membarrier_private_expedited_fail();
>> +       if (status)
>> +               return status;
>> +       status = test_membarrier_register_private_expedited_success();
>> +       if (status)
>> +               return status;
>> +       status = test_membarrier_private_expedited_success();
>>         if (status)
>>                 return status;
>>         return 0;
>> --
>> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
