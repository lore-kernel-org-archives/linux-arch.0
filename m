From: James Y Knight via llvm-dev <llvm-dev@lists.llvm.org>
Subject: Re: [isocpp-parallel] Proposal for new
 memory_order_consume definition
Date: Mon, 29 Feb 2016 16:10:11 -0500
Message-ID: <CAA2zVHoWMXS1JCzyMCV-ZQqtdAvDWUezShH42hrbAK4owhhmGw@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
 <20160220195318.GF3522@linux.vnet.ibm.com>
 <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
 <20160227170615.GU3522@linux.vnet.ibm.com>
 <CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
 <20160227231033.GW3522@linux.vnet.ibm.com>
 <20160228082702.GA300@x4>
 <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
 <CAA+UVZT9vK8CZdRr8P9=cDT6OhCz=zieHY81txnNdAAF4v_sPA@mail.gmail.com>
Reply-To: James Y Knight <jyknight@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7178735686557785091=="
Return-path: <llvm-dev-bounces@lists.llvm.org>
In-Reply-To: <CAA+UVZT9vK8CZdRr8P9=cDT6OhCz=zieHY81txnNdAAF4v_sPA@mail.gmail.com>
List-Unsubscribe: <http://lists.llvm.org/cgi-bin/mailman/options/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=unsubscribe>
List-Archive: <http://lists.llvm.org/pipermail/llvm-dev/>
List-Post: <mailto:llvm-dev@lists.llvm.org>
List-Help: <mailto:llvm-dev-request@lists.llvm.org?subject=help>
List-Subscribe: <http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=subscribe>
Errors-To: llvm-dev-bounces@lists.llvm.org
Sender: "llvm-dev" <llvm-dev-bounces@lists.llvm.org>
To: Lawrence Crowl <Lawrence@crowl.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, parallel@lists.isocpp.org, llvm-dev <llvm-dev@lists.llvm.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Ingo Molnar <mingo@kernel.org>, Markus Trippelsdorf <markus@trippelsdorf.de>
List-Id: linux-arch.vger.kernel.org

--===============7178735686557785091==
Content-Type: multipart/alternative; boundary=089e0149d0200a7747052cef13df

--089e0149d0200a7747052cef13df
Content-Type: text/plain; charset=UTF-8

No, you really don't need undefined behavior in the standard in order to
enable bug-finding.

The standard could've (and still could...) make signed integer overflow "
implementation-defined" rather than "undefined". Compilers would thus be
required to have *some documented meaning* for it (e.g. wrap
2's-complement, wrap 1's-complement, saturate to min/max, trap, or
whatever...), but must not have the current "Anything goes! I can set your
cat on fire if the optimizer feels like it today!" behavior.

Such a change to the standard would not reduce any ability to do error
checking, as compilers that want to be helpful could perfectly-well define
it to trap at runtime when given certain compiler flags, and perfectly well
warn you of your dependence upon unportable implementation-defined behavior
(or, that your program is going to trap), at build-time.

On Mon, Feb 29, 2016 at 2:38 PM, Lawrence Crowl via llvm-dev <
llvm-dev@lists.llvm.org> wrote:

> On 2/28/16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > The fact is, undefined compiler behavior is never a good idea. Not for
> > serious projects.
>
> Actually, undefined behavior is essential for serious projects, but
> not for the reasons mentioned.
>
> If the language has no undefined behavior, then from the compiler's view,
> there is no such thing as a bad program.  All programs will compile and
> enter functional debug (possibly after shipping to customer).  On the
> other hand, a language with undefined behavior makes it possible for
> compilers (and their run-time support) to identify a program as wrong.
>
> The problem with the latest spate of compiler optimizations was not the
> optimization, but the lack of warnings about exploiting undefined behavior.
>
> --
> Lawrence Crowl
> _______________________________________________
> LLVM Developers mailing list
> llvm-dev@lists.llvm.org
> http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
>

--089e0149d0200a7747052cef13df
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">No, you really don&#39;t need undefined behavior in the st=
andard in order to enable bug-finding.<div><br></div><div><div style=3D"fon=
t-size:12.8px">The standard could&#39;ve (and still could...) make signed i=
nteger overflow &quot;<span class=3D"">implementation</span>-<span class=3D=
"">defined</span>&quot; rather than &quot;undefined&quot;. Compilers=C2=A0w=
ould thus=C2=A0be required to have *some documented meaning* for it (e.g. w=
rap 2&#39;s-complement, wrap 1&#39;s-complement, saturate to min/max, trap,=
 or whatever...), but must not have the current &quot;Anything goes! I can =
set your cat on fire if the optimizer feels like it today!&quot; behavior.<=
/div><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px"><br><=
/span></div><div style=3D"font-size:12.8px"><span style=3D"font-size:12.8px=
">Such a change to the standard</span><span style=3D"font-size:12.8px">=C2=
=A0would not reduce any ability to do error checking, as compilers that wan=
t to be helpful could perfectly-well define it to trap at runtime when give=
n certain compiler flags, and perfectly well warn you of your dependence up=
on unportable implementation-defined behavior (or, that your program is goi=
ng to trap), at build-time.</span></div></div></div><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote">On Mon, Feb 29, 2016 at 2:38 PM, Lawrenc=
e Crowl via llvm-dev <span dir=3D"ltr">&lt;<a href=3D"mailto:llvm-dev@lists=
.llvm.org" target=3D"_blank">llvm-dev@lists.llvm.org</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D"">On 2/28/16, Linus Torval=
ds &lt;<a href=3D"mailto:torvalds@linux-foundation.org">torvalds@linux-foun=
dation.org</a>&gt; wrote:<br>
&gt; The fact is, undefined compiler behavior is never a good idea. Not for=
<br>
&gt; serious projects.<br>
<br>
</span>Actually, undefined behavior is essential for serious projects, but<=
br>
not for the reasons mentioned.<br>
<br>
If the language has no undefined behavior, then from the compiler&#39;s vie=
w,<br>
there is no such thing as a bad program.=C2=A0 All programs will compile an=
d<br>
enter functional debug (possibly after shipping to customer).=C2=A0 On the<=
br>
other hand, a language with undefined behavior makes it possible for<br>
compilers (and their run-time support) to identify a program as wrong.<br>
<br>
The problem with the latest spate of compiler optimizations was not the<br>
optimization, but the lack of warnings about exploiting undefined behavior.=
<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Lawrence Crowl<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
__________________________<br>
LLVM Developers mailing list<br>
<a href=3D"mailto:llvm-dev@lists.llvm.org">llvm-dev@lists.llvm.org</a><br>
<a href=3D"http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev" rel=3D"=
noreferrer" target=3D"_blank">http://lists.llvm.org/cgi-bin/mailman/listinf=
o/llvm-dev</a><br>
</div></div></blockquote></div><br></div>

--089e0149d0200a7747052cef13df--

--===============7178735686557785091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTExWTSBEZXZl
bG9wZXJzIG1haWxpbmcgbGlzdApsbHZtLWRldkBsaXN0cy5sbHZtLm9yZwpodHRwOi8vbGlzdHMu
bGx2bS5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2xsdm0tZGV2Cg==

--===============7178735686557785091==--
