From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [Xen-devel] [RFC v2 7/7] kprobes: port to linker table
Date: Tue, 23 Feb 2016 01:52:44 +0100
Message-ID: <20160223005244.GE25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-8-git-send-email-mcgrof@kernel.org>
 <50399556C9727B4D88A595C8584AAB37B4E0F41C@GSjpTKYDCembx32.service.hitachi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44768 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128AbcBWAwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Feb 2016 19:52:49 -0500
Content-Disposition: inline
In-Reply-To: <50399556C9727B4D88A595C8584AAB37B4E0F41C@GSjpTKYDCembx32.service.hitachi.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>
Cc: "'Luis R. Rodriguez'" <mcgrof@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "x86@kernel.org" <x86@kernel.org>, "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>, "jbaron@akamai.com" <jbaron@akamai.com>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "mcb30@ipxe.org" <mcb30@ipxe.org>, jgross@suse.c

On Mon, Feb 22, 2016 at 01:34:05AM +0000, =E5=B9=B3=E6=9D=BE=E9=9B=85=E5=
=B7=B3 / HIRAMATU=EF=BC=8CMASAMI wrote:
> >From: Luis R. Rodriguez [mailto:mcgrof@kernel.org]
> >
> >kprobe makes use of two custom sections:
> >
> >type       name                  begin                    end
> >init.data _kprobe_blacklist __start_kprobe_blacklist	__stop_kprobe_b=
lacklist
> >text      .kprobes.text     __kprobes_text_start        __kprobes_te=
xt_end
> >
> >Port these to the linker table generic solution. This lets
> >us remove all the custom kprobe section declarations on the
> >linker script.
> >
> >Tested with CONFIG_KPROBES_SANITY_TEST, it passes with:
> >
> >Kprobe smoke test: started
> >Kprobe smoke test: passed successfully
> >
> >Then tested CONFIG_SAMPLE_KPROBES on do_fork, and the
> >kprobe bites and kicks as expected. Lastly tried registering
> >a kprobe on a kprobe blacklisted symbol (NOKPROBE_SYMBOL()),
> >and confirms that fails to work.
>=20
> Could you also check to run the testcases by using ftracetest as belo=
w?
>=20
> $ cd tools/testing/selftests/ftrace/
> $ sudo ./ftracetest

Sure, it all passed:

$ sudo ./ftracetest
=3D=3D=3D Ftrace unit tests =3D=3D=3D
[1] Basic trace file check	[PASS]
[2] Basic test for tracers	[PASS]
[3] Basic trace clock test	[PASS]
[4] Basic event tracing check	[PASS]
[5] event tracing - enable/disable with event level files	[PASS]
[6] event tracing - enable/disable with subsystem level files	[PASS]
[7] event tracing - enable/disable with top level files	[PASS]
[8] ftrace - function graph filters with stack tracer	[PASS]
[9] ftrace - function graph filters	[PASS]
[10] ftrace - function profiler with function tracing	[PASS]
[11] Test creation and deletion of trace instances	[PASS]
[12] Kprobe dynamic event - adding and removing	[PASS]
[13] Kprobe dynamic event - busy event check	[PASS]
[14] Kprobe dynamic event with arguments	[PASS]
[15] Kprobe dynamic event with function tracer	[PASS]
[16] Kretprobe dynamic event with arguments	[PASS]

# of passed:  16
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  0
# of undefined(test bug):  0

> And I'm not sure about linker table.

So there's really a few parts to the linker table work, out of
the ones that relate to kprobes:

  * linker tables try to generalize our section use, and provide some
    helpers for common section use
  * provides helpers to make it easier to make custom section,
    but by re-using standard sections
  * when a custom section uses standard sections and helpers
    we also get a few gains:
    - developers reviewing code can more easily get a quicker
      understanding and have expectations set of how the code
      feature using the custom section could be used
    - people grep'ing on the kernel can more easily find
      specific types of custom section use by looking for
      the type of interest
    - developers adding features do not need to modify
      any linker scripts (vmlinux.lds.S) to make use of
      custom sections

In kprobe's case, since it uses two custom sections, we have
only a small use for the first case: .kprobe.text is just used
as a place holder for future developer annotated special cased
executable code. It also makes use of the generic helpers:
LINKTABLE_ADDR_WITHIN(), LINKTABLE_START(), LINKTABLE_END().

The second use case, for the _kprobe_blacklist, makes much more
use of the more advanced linker table helpers, for instance the
iterator LINKTABLE_FOR_EACH().

=46or both though we now have each custom section's actual section
clearly highlighted:

  * kprobes: .text (SECTION_TEXT)
  * kprobe blacklist: init.data (SECTION_INIT_DATA)

A reader / developer can more easily gain an understanding
of how the above custom sections could be used just by its
type.

Another feature of linker tables, but outside of the scope of how kprob=
e
would use linker tables, is the ability to enable folks to avoid code
bit rot by using table-$(CONFIG_FOO) instead of oby-$(CONFIG_FOO) on
init paths of code but since this is outside of the scope of how kprobe=
 would
use I leave that just as a reference as another part of linker table.
Unless of course you want to make people force compile all kprobe
support code but only have it linked in when actually enabled. That
would be outside of the scope and purpose of this patch though.

> Is that possible to support
> __kprobes prefix, which moves the functions into kprobes.text?

Absolutely, the respective change was just to annotate and make
it clear the section kprobes were using:

-# define __kprobes     __attribute__((__section__(".kprobes.text")))
+#include <linux/sections.h>
+# define __kprobes     __attribute__((__section__(SECTION_TBL(SECTION_=
TEXT, kprobes, all))))

> Actually, I'm on the way to replacing __kprobes to NOKPROBE_SYMBOL
> macro, since NOKPROBE_SYMBOL() doesn't effect the kernel text itself.
> On x86, it is already replaced (see commit 820aede0209a), and same
> work should be done on other archs. So, could you hold this after
> that?

Sure.

> I think we should remove .kprobes.text first=20

You mean just remove the incorrect users of .kprobes.text because as I =
read
what you described above we have abuse of __kprobes use to protect agai=
nst
kprobes being introduced on those routines, and we should be using
NOKPROBE_SYMBOL() instead. So from what I gather its not that you will
remove .kprobes.text but rather clean our current abuse of __kprobes
for protection to use NOKPROBE_SYMBOL() instead. Is that right?

> and move to  linker table.

Sure, can you Cc me on your patches? I can follow up later.

  Luis
