Return-Path: <frowand.list@gmail.com>
Subject: Re: [PATCH v2 6/7] kunit: Add 'kunit_shutdown' option
From: Frank Rowand <frowand.list@gmail.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-7-brendanhiggins@google.com>
 <143dcdac-b19a-8eff-b441-ba79f1873801@gmail.com>
Message-ID: <8f7a5e34-d386-abcd-9926-1bd4cab8aeef@gmail.com>
Date: Tue, 4 Feb 2020 17:05:51 -0600
MIME-Version: 1.0
In-Reply-To: <143dcdac-b19a-8eff-b441-ba79f1873801@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200204230551.IAQE3LQ5cCtytX0bgCIoaQ0vmr4cz5473iuu1RWT_ZA@z>

On 2/4/20 5:05 PM, Frank Rowand wrote:
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
>> From: David Gow <davidgow@google.com>
>>
>> Add a new kernel command-line option, 'kunit_shutdown', which allows the
>> user to specify that the kernel poweroff, halt, or reboot after
>> completing all KUnit tests; this is very handy for running KUnit tests
>> on UML or a VM so that the UML/VM process exits cleanly immediately
>> after running all tests without needing a special initramfs.
> 
> kunit_shutdown needs to be added to Documentation/admin-guide/kernel-parameters.txt

Oops, patch 7/7 does exactly that.

-Frank

> 
> -Frank
> 
>>
>> Signed-off-by: David Gow <davidgow@google.com>
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>> ---
>>  lib/kunit/executor.c                | 20 ++++++++++++++++++++
>>  tools/testing/kunit/kunit_kernel.py |  2 +-
>>  tools/testing/kunit/kunit_parser.py |  2 +-
>>  3 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
>> index 7fd16feff157e..a93821116ccec 100644
>> --- a/lib/kunit/executor.c
>> +++ b/lib/kunit/executor.c
>> @@ -1,5 +1,6 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  
>> +#include <linux/reboot.h>
>>  #include <kunit/test.h>
>>  
>>  /*
>> @@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>>  
>>  #if IS_BUILTIN(CONFIG_KUNIT)
>>  
>> +static char *kunit_shutdown;
>> +core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
>> +
>> +static void kunit_handle_shutdown(void)
>> +{
>> +	if (!kunit_shutdown)
>> +		return;
>> +
>> +	if (!strcmp(kunit_shutdown, "poweroff"))
>> +		kernel_power_off();
>> +	else if (!strcmp(kunit_shutdown, "halt"))
>> +		kernel_halt();
>> +	else if (!strcmp(kunit_shutdown, "reboot"))
>> +		kernel_restart(NULL);
>> +
>> +}
>> +
>>  static void kunit_print_tap_header(void)
>>  {
>>  	struct kunit_suite * const * const *suites, * const *subsuite;
>> @@ -42,6 +60,8 @@ int kunit_run_all_tests(void)
>>  		}
>>  	}
>>  
>> +	kunit_handle_shutdown();
>> +
>>  	if (has_test_failed)
>>  		return -EFAULT;
>>  
>> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
>> index cc5d844ecca13..43314aa537d30 100644
>> --- a/tools/testing/kunit/kunit_kernel.py
>> +++ b/tools/testing/kunit/kunit_kernel.py
>> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>>  		return True
>>  
>>  	def run_kernel(self, args=[], timeout=None, build_dir=''):
>> -		args.extend(['mem=256M'])
>> +		args.extend(['mem=256M', 'kunit_shutdown=halt'])
>>  		process = self._ops.linux_bin(args, timeout, build_dir)
>>  		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>>  			for line in process.stdout:
>> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
>> index 78b3bdd03b1e4..633811dd9bce8 100644
>> --- a/tools/testing/kunit/kunit_parser.py
>> +++ b/tools/testing/kunit/kunit_parser.py
>> @@ -48,7 +48,7 @@ class TestStatus(Enum):
>>  	FAILURE_TO_PARSE_TESTS = auto()
>>  
>>  kunit_start_re = re.compile(r'^TAP version [0-9]+$')
>> -kunit_end_re = re.compile('List of all partitions:')
>> +kunit_end_re = re.compile(r'reboot: System halted')
>>  
>>  def isolate_kunit_output(kernel_output):
>>  	started = False
>>
> 
> 
