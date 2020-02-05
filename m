Return-Path: <frowand.list@gmail.com>
Subject: Re: [PATCH v2 7/7] Documentation: Add kunit_shutdown to
 kernel-parameters.txt
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-8-brendanhiggins@google.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <d187686e-a175-e30b-2af9-6e00822fed5c@gmail.com>
Date: Tue, 4 Feb 2020 18:19:07 -0600
MIME-Version: 1.0
In-Reply-To: <20200130230812.142642-8-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200205001907.J5ItirZf9DtP23N31K4dnBOO0GAspj_4O_L9-v2ppp0@z>

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> Add kunit_shutdown, an option to specify that the kernel shutsdown after
> running KUnit tests, to the kernel-parameters.txt documentation.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e03..522fd8bdec949 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2054,6 +2054,13 @@
>  			0: force disabled
>  			1: force enabled
>  
> +	kunit_shutdown	[KERNEL UNIT TESTING FRAMEWORK] Shutdown kernel after
> +			running tests.

                        running built-in tests.  Tests configured as modules will not be run.

My wording might not be consistent with KUnit terminology regarding "built-in" and "modules".
Feel free to properly word smith.


> +			Default:	(flag not present) don't shutdown
> +			poweroff:	poweroff the kernel after running tests
> +			halt:		halt the kernel after running tests
> +			reboot:		reboot the kernel after running tests
> +
>  	kvm.ignore_msrs=[KVM] Ignore guest accesses to unhandled MSRs.
>  			Default is 0 (don't ignore, but inject #GP)
>  
> 
