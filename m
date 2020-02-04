From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v2 2/7] arch: um: add linker section for KUnit test suites
Date: Tue, 4 Feb 2020 15:59:11 -0600
Message-ID: <e060bdfc-5cdb-fb62-48b0-cc54c7bc72ce@gmail.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-3-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200130230812.142642-3-brendanhiggins@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com
Cc: gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 1/30/20 5:08 PM, Brendan Higgins wrote:
> Add a linker section to UML where KUnit can put references to its test
> suites. This patch is an early step in transitioning to dispatching all
> KUnit tests from a centralized executor rather than having each as its
> own separate late_initcall.

All architectures please.

The early versions of Kunit documented reliance on UML.  Discussion lead to
the conclusion that real architectures and real hardware would be supported.

This like this are what make me reluctant to move devicetree unittests to
KUnit.

Can you please add a section to the KUnit documentation that lists things
like the expectations, requirements, limitations, etc for a test case that
is run by KUnit?  Some examples that pop to mind from recent discussions
and my own experiences:

  - Each test case is invoked after late_init is complete.
      + Exception: the possible value of being able to run a unit test
        at a specific runlevel has been expressed.  If an actual unit
        test can be shown to require running earlier, this restriction
        will be re-visited.

  - Each test case must be idempotent.  Each test case may be called
    multiple times, and must generate the same result each time it
    is called.
      + Exception 1: a test case can be declared to not be idempotent
        [[ mechanism TBD ]], in which case KUnit will not call the
        test case a second time without the kernel rebooting.
      + Exception 2: hardware may not be deterministic, so a test that
        always passes or fails when run under UML may not always to
        so on real hardware.  <--- sentence copied from
        Documentation/dev-tools/kunit/usage.rst
          [[ This item and 1st exception do not exist yet, but will exist
          in some form if the proposed proc filesystem interface is
          added. ]]

  - KUnit provides a helpful wrapper to simplify building a UML kernel
    containing the KUnit test cases, booting the UML kernel, and
    formatting the output from the test cases.  This wrapper MUST NOT
    be required to run the test cases or to determine a test result.
    The formatting may provide additional analysis and improve
    readability of a test result.

  - .... There is more that belongs here, but I'm getting side tracked
    here, when I'm trying to instead convert devicetree unittests to
    KUnit and want to get back to that.


-Frank

> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/um/include/asm/common.lds.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index 7145ce6999822..eab9ceb450efd 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -52,6 +52,10 @@
>  	CON_INITCALL
>    }
>  
> +  .kunit_test_suites : {
> +	KUNIT_TEST_SUITES
> +  }
> +
>    .exitcall : {
>  	__exitcall_begin = .;
>  	*(.exitcall.exit)
> 
