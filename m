Return-Path: <SRS0=HMh4=7K=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-12-catalin.marinas@arm.com> <CAMn1gO5ApcHOgQ_oLjiGDdCx9znz7N50w-BbzGPYpAzPQC3OQQ@mail.gmail.com>
 <20200528091445.GA2961@gaia> <20200528110509.GA18623@arm.com> <20200528163412.GC2961@gaia>
In-Reply-To: <20200528163412.GC2961@gaia>
From: Evgenii Stepanov <eugenis@google.com>
Date: Thu, 28 May 2020 11:35:50 -0700
Message-ID: <CAFKCwri+X=de0gFrMZfA84dYmftSkcDc0DEvQ2JAmeOw2sLR=A@mail.gmail.com>
Subject: Re: [PATCH v4 11/26] arm64: mte: Add PROT_MTE support to mmap() and mprotect()
Content-Type: multipart/alternative; boundary="000000000000d9931405a6b99917"
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, Peter Collingbourne <pcc@google.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, nd <nd@arm.com>
List-ID: <linux-arch.vger.kernel.org>

--000000000000d9931405a6b99917
Content-Type: text/plain; charset="UTF-8"

On Thu, May 28, 2020 at 9:34 AM Catalin Marinas <catalin.marinas@arm.com>
wrote:

> On Thu, May 28, 2020 at 12:05:09PM +0100, Szabolcs Nagy wrote:
> > The 05/28/2020 10:14, Catalin Marinas wrote:
> > > On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wrote:
> > > > On Fri, May 15, 2020 at 10:16 AM Catalin Marinas
> > > > <catalin.marinas@arm.com> wrote:
> > > > > To enable tagging on a memory range, the user must explicitly opt
> in via
> > > > > a new PROT_MTE flag passed to mmap() or mprotect(). Since this is
> a new
> > > > > memory type in the AttrIndx field of a pte, simplify the or'ing of
> these
> > > > > bits over the protection_map[] attributes by making MT_NORMAL
> index 0.
> > > >
> > > > Should the userspace stack always be mapped as if with PROT_MTE if
> the
> > > > hardware supports it? Such a change would be invisible to non-MTE
> > > > aware userspace since it would already need to opt in to tag checking
> > > > via prctl. This would let userspace avoid a complex stack
> > > > initialization sequence when running with stack tagging enabled on
> the
> > > > main thread.
> > >
> > > I don't think the stack initialisation is that difficult. On program
> > > startup (can be the dynamic loader). Something like (untested):
> > >
> > >     register unsigned long stack asm ("sp");
> > >     unsigned long page_sz = sysconf(_SC_PAGESIZE);
> > >
> > >     mprotect((void *)(stack & ~(page_sz - 1)), page_sz,
> > >              PROT_READ | PROT_WRITE | PROT_MTE | PROT_GROWSDOWN);
> > >
> > > (the essential part it PROT_GROWSDOWN so that you don't have to specify
> > > a stack lower limit)
> >
> > does this work even if the currently mapped stack is more than page_sz?
> > determining the mapped main stack area is i think non-trivial to do in
> > userspace (requires parsing /proc/self/maps or similar).
>
> Because of PROT_GROWSDOWN, the kernel adjusts the start of the range
> down automatically. It is potentially problematic if the top of the
> stack is more than a page away and you want the whole stack coloured. I
> haven't run a test but my reading of the kernel code is that the stack
> vma would be split in this scenario, so the range beyond sp+page_sz
> won't have PROT_MTE set.
>
> My assumption is that if you do this during program start, the stack is
> smaller than a page. Alternatively, could we use argv or envp to
> determine the top of the user stack (the bottom is taken care of by the
> kernel)?
>

PROT_GROWSDOWN seems to work fine in our case, and the extra tag
maintenance overhead sounds like a valid argument against setting PROT_MTE
unconditionally.

On the other hand, we may end up doing this in the userspace in every
process. The reason is, PROT_MTE can not be set on a page that contains a
live frame with stack tagging because of mismatching tags (IRG is not
affected by PROT_MTE but STG is). So ideally, this should be done at (or
near) the program entry point, while the stack is mostly empty.


>
> > > I'm fine, however, with enabling PROT_MTE on the main stack based on
> > > some ELF note.
> >
> > note that would likely mean an elf note on the dynamic linker
> > (because a dynamic linked executable may not be loaded by the
> > kernel and ctors in loaded libs run before the executable entry
> > code anyway, so the executable alone cannot be in charge of this
> > decision) i.e. one global switch for all dynamic linked binaries.
>
> I guess parsing such note in the kernel is only useful for static
> binaries.
>
> > i think a dynamic linker can map a new stack and switch to it
> > if it needs to control the properties of the stack at runtime
> > (it's wasteful though).
>
> There is already user code to check for HWCAP2_MTE and the prctl(), so
> adding an mprotect() doesn't look like a significant overhead.
>
> > and i think there should be a runtime mechanism for the brk area:
> > it should be possible to request that future brk expansions are
> > mapped as PROT_MTE so an mte aware malloc implementation can use
> > brk. i think this is not important in the initial design, but if
> > a prctl flag can do it that may be useful to add (may be at a
> > later time).
>
> Looking at the kernel code briefly, I think this would work. We do end
> up with two vmas for the brk, only the expansion having PROT_MTE, and
> I'd to find a way to store the extra flag.
>
> From a coding perspective, it's easier to just set PROT_MTE by default
> on both brk and initial stack ;) (VM_DATA_DEFAULT_FLAGS).
>
> > (and eventually there should be a way to use PROT_MTE on
> > writable global data and appropriate code generation that
> > takes colors into account when globals are accessed, but
> > that requires significant ELF, ld.so and compiler changes,
> > that need not be part of the initial mte design).
>
> The .data section needs to be driven by the ELF information. It's also a
> file mapping and we don't support PROT_MTE on them even if MAP_PRIVATE.
> There are complications like DAX where the file you mmap for CoW may be
> hosted on memory that does not support MTE (copied to RAM on write).
>
> Is there a use-case for global data to be tagged?
>

Yes, catching global buffer overflow bugs. They are not nearly as common as
heap-based issues though.


>
> --
> Catalin
>

--000000000000d9931405a6b99917
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 28, 2020 at 9:34 AM Catal=
in Marinas &lt;<a href=3D"mailto:catalin.marinas@arm.com">catalin.marinas@a=
rm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Thu, May 28, 2020 at 12:05:09PM +0100, Szabolcs Nagy wrote:<br>
&gt; The 05/28/2020 10:14, Catalin Marinas wrote:<br>
&gt; &gt; On Wed, May 27, 2020 at 11:57:39AM -0700, Peter Collingbourne wro=
te:<br>
&gt; &gt; &gt; On Fri, May 15, 2020 at 10:16 AM Catalin Marinas<br>
&gt; &gt; &gt; &lt;<a href=3D"mailto:catalin.marinas@arm.com" target=3D"_bl=
ank">catalin.marinas@arm.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; To enable tagging on a memory range, the user must expl=
icitly opt in via<br>
&gt; &gt; &gt; &gt; a new PROT_MTE flag passed to mmap() or mprotect(). Sin=
ce this is a new<br>
&gt; &gt; &gt; &gt; memory type in the AttrIndx field of a pte, simplify th=
e or&#39;ing of these<br>
&gt; &gt; &gt; &gt; bits over the protection_map[] attributes by making MT_=
NORMAL index 0.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Should the userspace stack always be mapped as if with PROT_=
MTE if the<br>
&gt; &gt; &gt; hardware supports it? Such a change would be invisible to no=
n-MTE<br>
&gt; &gt; &gt; aware userspace since it would already need to opt in to tag=
 checking<br>
&gt; &gt; &gt; via prctl. This would let userspace avoid a complex stack<br=
>
&gt; &gt; &gt; initialization sequence when running with stack tagging enab=
led on the<br>
&gt; &gt; &gt; main thread.<br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t think the stack initialisation is that difficult. On =
program<br>
&gt; &gt; startup (can be the dynamic loader). Something like (untested):<b=
r>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0register unsigned long stack asm (&quot;sp&quo=
t;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0unsigned long page_sz =3D sysconf(_SC_PAGESIZE=
);<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0mprotect((void *)(stack &amp; ~(page_sz - 1)),=
 page_sz,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PROT_READ | PROT_=
WRITE | PROT_MTE | PROT_GROWSDOWN);<br>
&gt; &gt; <br>
&gt; &gt; (the essential part it PROT_GROWSDOWN so that you don&#39;t have =
to specify<br>
&gt; &gt; a stack lower limit)<br>
&gt; <br>
&gt; does this work even if the currently mapped stack is more than page_sz=
?<br>
&gt; determining the mapped main stack area is i think non-trivial to do in=
<br>
&gt; userspace (requires parsing /proc/self/maps or similar).<br>
<br>
Because of PROT_GROWSDOWN, the kernel adjusts the start of the range<br>
down automatically. It is potentially problematic if the top of the<br>
stack is more than a page away and you want the whole stack coloured. I<br>
haven&#39;t run a test but my reading of the kernel code is that the stack<=
br>
vma would be split in this scenario, so the range beyond sp+page_sz<br>
won&#39;t have PROT_MTE set.<br>
<br>
My assumption is that if you do this during program start, the stack is<br>
smaller than a page. Alternatively, could we use argv or envp to<br>
determine the top of the user stack (the bottom is taken care of by the<br>
kernel)?<br></blockquote><div><br></div><div><span style=3D"color:rgb(80,0,=
80)">PROT_GROWSDOWN seems to work fine in our case, and the extra tag maint=
enance overhead sounds like a valid argument against setting PROT_MTE uncon=
ditionally.</span><br></div><div><span style=3D"color:rgb(80,0,80)"><br></s=
pan></div><div><span style=3D"color:rgb(80,0,80)">On the other hand, we may=
 end up doing this in the userspace in every process. The reason is, PROT_M=
TE can not be set on a page that contains a live frame with stack tagging b=
ecause of mismatching tags (IRG is not affected by PROT_MTE but STG is). So=
 ideally, this should be done at (or near) the program entry point, while t=
he stack is mostly empty.</span></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
&gt; &gt; I&#39;m fine, however, with enabling PROT_MTE on the main stack b=
ased on<br>
&gt; &gt; some ELF note.<br>
&gt; <br>
&gt; note that would likely mean an elf note on the dynamic linker<br>
&gt; (because a dynamic linked executable may not be loaded by the<br>
&gt; kernel and ctors in loaded libs run before the executable entry<br>
&gt; code anyway, so the executable alone cannot be in charge of this<br>
&gt; decision) i.e. one global switch for all dynamic linked binaries.<br>
<br>
I guess parsing such note in the kernel is only useful for static<br>
binaries.<br>
<br>
&gt; i think a dynamic linker can map a new stack and switch to it<br>
&gt; if it needs to control the properties of the stack at runtime<br>
&gt; (it&#39;s wasteful though).<br>
<br>
There is already user code to check for HWCAP2_MTE and the prctl(), so<br>
adding an mprotect() doesn&#39;t look like a significant overhead.<br>
<br>
&gt; and i think there should be a runtime mechanism for the brk area:<br>
&gt; it should be possible to request that future brk expansions are<br>
&gt; mapped as PROT_MTE so an mte aware malloc implementation can use<br>
&gt; brk. i think this is not important in the initial design, but if<br>
&gt; a prctl flag can do it that may be useful to add (may be at a<br>
&gt; later time).<br>
<br>
Looking at the kernel code briefly, I think this would work. We do end<br>
up with two vmas for the brk, only the expansion having PROT_MTE, and<br>
I&#39;d to find a way to store the extra flag.<br>
<br>
From a coding perspective, it&#39;s easier to just set PROT_MTE by default<=
br>
on both brk and initial stack ;) (VM_DATA_DEFAULT_FLAGS).<br>
<br>
&gt; (and eventually there should be a way to use PROT_MTE on<br>
&gt; writable global data and appropriate code generation that<br>
&gt; takes colors into account when globals are accessed, but<br>
&gt; that requires significant ELF, ld.so and compiler changes,<br>
&gt; that need not be part of the initial mte design).<br>
<br>
The .data section needs to be driven by the ELF information. It&#39;s also =
a<br>
file mapping and we don&#39;t support PROT_MTE on them even if MAP_PRIVATE.=
<br>
There are complications like DAX where the file you mmap for CoW may be<br>
hosted on memory that does not support MTE (copied to RAM on write).<br>
<br>
Is there a use-case for global data to be tagged?<br></blockquote><div><br>=
</div><div>Yes, catching global buffer overflow bugs. They are not nearly a=
s common as heap-based issues though.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Catalin<br>
</blockquote></div></div>

--000000000000d9931405a6b99917--
