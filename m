From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v3 1/9] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Date: Fri, 8 Nov 2019 15:23:31 +0100
Message-ID: <20191108142331.GA201027@google.com>
References: <20191104142745.14722-1-elver@google.com>
 <20191104142745.14722-2-elver@google.com>
 <CACi5LpMt1Jp3zi3dQXe-x=nZ4ikADoD2Sr4-6t4HKaarLs7uxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACi5LpMt1Jp3zi3dQXe-x=nZ4ikADoD2Sr4-6t4HKaarLs7uxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, Alexander Potapenko <glider@google.com>, parri.andrea@gmail.com, andreyknvl@google.com, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, boqun.feng@gmail.com, Borislav Petkov <bp@alien8.de>, dja@axtens.net, dlustig@nvidia.com, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, j.alglave@ucl.ac.uk, joel@joelfernandes.org, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, luc.maranget@inria.fr, Mark Rutland <mark.rutland@arm.com>, npiggin@gmail.com, paulmck@kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Bhupesh,

Thanks for your comments, see answers below.

On Fri, 08 Nov 2019, Bhupesh Sharma wrote:

> Sorry for the late comments, but I am just trying to understand the
> new KCSAN feature (which IMO seems very useful for debugging issues).
> 
> Some comments inline:
> 
> On Mon, Nov 4, 2019 at 7:59 PM Marco Elver <elver@google.com> wrote:
> >
...
> > diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> > new file mode 100644
> > index 000000000000..bd8122acae01
> > --- /dev/null
> > +++ b/include/linux/kcsan.h
> > @@ -0,0 +1,115 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_KCSAN_H
> > +#define _LINUX_KCSAN_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/kcsan-checks.h>
> 
> For the new changes introduced (especially the new header files), can
> we please try to keep the alphabetical order
> for the include'd files.
> 
> The same comment applies for changes below ...

Done for v4.

...
> > +void kcsan_disable_current(void)
> > +{
> > +       ++get_ctx()->disable_count;
> > +}
> > +EXPORT_SYMBOL(kcsan_disable_current);
> > +
> > +void kcsan_enable_current(void)
> > +{
> > +       if (get_ctx()->disable_count-- == 0) {
> > +               kcsan_disable_current(); /* restore to 0 */
> > +               kcsan_disable_current();
> > +               WARN(1, "mismatching %s", __func__);
> 
> I am not sure I understand, why we need to call
> 'kcsan_disable_current()' twice and what the WARN message conveys.
> May-be you can add a comment here, or a more descriptive WARN meesage.

This branch is entered when there is an imbalance between
kcsan_disable_current and kcsan_enable_current calls. When entering the
branch, the decrement transitioned disable_count to -1, which should not
happen. The call to kcsan_disable_current restores it to 0, and the
following kcsan_disable_current actually disables KCSAN for generating
the warning.

> > +               kcsan_enable_current();
> > +       }
> > +}
> > +EXPORT_SYMBOL(kcsan_enable_current);
> > +
> > +void kcsan_nestable_atomic_begin(void)
> > +{
> > +       /*
> > +        * Do *not* check and warn if we are in a flat atomic region: nestable
> > +        * and flat atomic regions are independent from each other.
> > +        * See include/linux/kcsan.h: struct kcsan_ctx comments for more
> > +        * comments.
> > +        */
> > +
> > +       ++get_ctx()->atomic_nest_count;
> > +}
> > +EXPORT_SYMBOL(kcsan_nestable_atomic_begin);
> > +
> > +void kcsan_nestable_atomic_end(void)
> > +{
> > +       if (get_ctx()->atomic_nest_count-- == 0) {
> > +               kcsan_nestable_atomic_begin(); /* restore to 0 */
> > +               kcsan_disable_current();
> > +               WARN(1, "mismatching %s", __func__);
> 
> .. Same as above.

Same situation, except for atomic_nest_count. Here also
atomic_nest_count is -1 which should not happen.

I've added some more comments.

> > +               kcsan_enable_current();
> > +       }
> > +}
> > +EXPORT_SYMBOL(kcsan_nestable_atomic_end);

Best Wishes,
-- Marco
