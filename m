From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to
 dispatch all KUnit tests
Date: Fri, 26 Jun 2020 14:52:37 -0700
Message-ID: <202006261442.5C245709@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Sender: linux-doc-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> This patchset adds a centralized executor to dispatch tests rather than
> relying on late_initcall to schedule each test suite separately along
> with a couple of new features that depend on it.

So, the new section looks fine to me (modulo the INIT_DATA change). The
plumbing to start the tests, though, I think is redundant. Why not just
add a sysctl that starts all known tests?

That way you don't need the plumbing into init/main.c, and you can have
a mode where builtin tests can be started on a fully booted system too.

i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
"echo start > /proc/sys/kernel/kunit"

And instead of the kunit-specific halt/reboot stuff, how about moving
/proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
do:

sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

-- 
Kees Cook
