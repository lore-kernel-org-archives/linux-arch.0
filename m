From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Mon, 20 Jul 2020 23:31:16 +0200
Message-ID: <CAKgNAkggayFEjHgPNu1HzvXGfSDoCq=Y-Ni4iv=RBYk2Eb6U1Q@mail.gmail.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
 <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com> <20200720165205.GI30452@arm.com>
Reply-To: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200720165205.GI30452-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hello Dave,

TL;DR: don't worry about the small stuff; I'm happy to do the minor
edits given the high quality of your patches.

On Mon, 20 Jul 2020 at 18:52, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On Mon, Jun 29, 2020 at 01:52:24PM +0200, Michael Kerrisk (man-pages) wrote:
> > Hi Dave,
> >
> > On 6/24/20 7:36 PM, Dave Martin wrote:
> > > A bunch of updates to the prctl(2) man page to fill in missing
> > > prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> > > fixes).
> > >
> > > Patches from the v2 series [1] that have been applied or rejected
> > > already have been dropped.
> > >
> > > All that remain here now are the SVE and tagged address ABI controls
> > > for arm64.
> > >
> > >
> > >
> > > [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin-5wv7dgnIgG8@public.gmane.org/
> > >
> > >
> > > Dave Martin (2):
> > >   prctl.2: Add SVE prctls (arm64)
> > >   prctl.2: Add tagged address ABI control prctls (arm64)
> > >
> > >  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 331 insertions(+)
> > Thanks. I've pushed these changes to master now.
>
> Thanks -- btw I finally got around to reviewing master, and noted a few
> editorial changes that man-pages(7) does not make any statement about:
>
> "arg1, arg2, and arg3"
>
>         Do you strictly prefer the command before "and" here?
>
>         Conventionally, the final comma would typically be omitted in
>         prose, except where the list members are complex enough that the
>         command is required to assist parsing.  However, lists of formal
>         arguments are not quite vanilla prose.

There are two camps wrt that comma. I prefer the so-called Oxford
comma convention, as shown above. man-pages uses it generally.

> "Providing that" -> "Provided that"
>
>         Any particular rationale here?

Either would be fine; the past tense is just slightly better, to my ear.

> "error EFOO" -> "the error EFOO"
>
>         Is this a rule, in general?

I think the change that you refer to was actually: "with EFOO" to
"with the error EFOO". The former is just a little too brief, to my
ear.

> .IP \(bu 2
>
>         I assumed that specifying an explicit indentation amount would
>         be fragile.  Going with the default behaviour also tends to
>         result in a more consistent appearance.  Do you have any
>         recommandations in this area?
>
>         Do you have rules about the order to use bullet symbols?  I tend
>         to avoid \(bu if possible, since while it's "correct", nroff can
>         render it nastily as an unadorned letter "o" (e.g., with -Tascii
>         or LC_CTYPE=C).  This is particlarly annoying if the indent is
>         <= 2, since then the "o" tends to be visually swallowed by the
>         following text (i.e., to a casual glance it looks like a word,
>         particlarly if the following text is not capitalised).  Perhaps
>         this is a bad glyph substitution decision in nroff rather than
>         something that should be fixed in the man-pages source, but the
>         man-pages source may be easier to fix...
>
>         There is already inconsistency here: there are may top-level
>         lists using ".IP *" in prctl.2, and plenty of places where the
>         default indentation is used.

I must admit that I'm in the process of rethinking bulleted lists, and
I have not come to a conclusion (and that's why nothing is said in
man-pages(7), and also why there is currently inconsistency).

Using .IP with the default indent (8n) results in a very deep indent
between the glyph and the text, so it's not my preference.

Your note about the poor rendering with "-Tascii" is interesting.
Perhaps ".IP \(bu 3" may be better. But, I really do not know: do
people really render with "-Tascii" these days?

> Should any of these be written up in man-pages(7), or is there a checker
> than can detect them?

Perhaps man-pages should say something about the Oxford comma.

> I wan't to minimise the amount of tweaking you have to do when merging
> patches.

If every patch that I received was of the same quality as yours are,
my life would be much easier. The tweaks are minimal work on my part.
Don't worry. Just send me more patches :-).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
