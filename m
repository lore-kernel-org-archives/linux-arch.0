From: Hans Boehm via llvm-dev <llvm-dev@lists.llvm.org>
Subject: Re: [isocpp-parallel] Proposal for new
	memory_order_consume definition
Date: Thu, 25 Feb 2016 16:46:50 -0800
Message-ID: <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
 <20160220195318.GF3522@linux.vnet.ibm.com>
Reply-To: Hans Boehm <boehm@acm.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5891289396364423272=="
Return-path: <llvm-dev-bounces@lists.llvm.org>
In-Reply-To: <20160220195318.GF3522@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.llvm.org/cgi-bin/mailman/options/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=unsubscribe>
List-Archive: <http://lists.llvm.org/pipermail/llvm-dev/>
List-Post: <mailto:llvm-dev@lists.llvm.org>
List-Help: <mailto:llvm-dev-request@lists.llvm.org?subject=help>
List-Subscribe: <http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev>,
 <mailto:llvm-dev-request@lists.llvm.org?subject=subscribe>
Errors-To: llvm-dev-bounces@lists.llvm.org
Sender: "llvm-dev" <llvm-dev-bounces@lists.llvm.org>
To: parallel@lists.isocpp.org
Cc: linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm-dev@lists.llvm.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, peterz@infradead.org, Ramana.Radhakrishnan@arm.com, Luc Maranget <luc.maranget@inria.fr>, akpm@linux-foundation.org, Jade Alglave <j.alglave@ucl.ac.uk>, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

--===============5891289396364423272==
Content-Type: multipart/alternative; boundary=001a113f92287bc435052ca1a22e

--001a113f92287bc435052ca1a22e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If carries_dependency affects semantics, then it should not be an attribute=
.

The original design, or at least my understanding of it, was that it not
have semantics; it was only a suggestion to the compiler that it should
preserve dependencies instead of inserting a fence at the call site.
Dependency-based ordering would be preserved in either case.  But I think
we're moving away from that view towards something that doesn't quietly add
fences.

I do not think we can quite get away with defining a dependency in a way
that is unconditionally preserved by existing compilers, and thus I think
that we do probably need annotations along the dependency path.  I just
don't see a way to otherwise deal with the case in which a compiler infers
an equivalent pointer and dereferences that instead of the original.  This
can happen under so many (unlikely but) hard-to-define conditions that it
seems undefinable in an implementation-independent manner. "If the
implementation is able then <the semantics change>" is, in my opinion, not
acceptable standards text.

Thus I see no way to both avoid adding syntax to functions that preserve
dependencies and continue to allow existing transformations that remove
dependencies we care about, e.g. due to equality comparisons.  We can
hopefully ensure that without annotations compilers break things with very
low probability, so that there is a reasonable path forward for existing
code relying on dependency ordering (which currently also breaks with very
low probability unless you understand what the compiler is doing).  But I
don't see a way for the standard to guarantee correctness without the added
syntax (or added optimization constraints that effectively assume all
functions were annotated).

On Sat, Feb 20, 2016 at 11:53 AM, Paul E. McKenney <
paulmck@linux.vnet.ibm.com> wrote:

> On Fri, Feb 19, 2016 at 09:15:16PM -0500, Tony V E wrote:
> > There's at least one easy answer in there:
> >
> > > =E2=80=8EIf implementations must support annotation, what form should=
 that
> >       annotation take?  P0190R0 recommends the [[carries_dependency]]
> >       attribute, but I am not picky as long as it can be (1) applied
> >       to all relevant pointer-like objects and (2) used in C as well
> >       as C++.  ;-)
> >
> > If an implementation must support it, then it is not an annotation but =
a
> keyword. So no [[]]
>
> I would be good with that approach, especially if the WG14 continues
> to stay away from annotations.
>
> For whatever it is worth, the introduction of intrinsics for comparisons
> that avoid breaking dependencies enables the annotation to remain
> optional.
>
>                                                         Thanx, Paul
>
> > Sent from my BlackBerry portable Babbage Device
> >   Original Message
> > From: Paul E. McKenney
> > Sent: Thursday, February 18, 2016 4:58 AM
> > To: parallel@lists.isocpp.org; linux-kernel@vger.kernel.org;
> linux-arch@vger.kernel.org; gcc@gcc.gnu.org; llvm-dev@lists.llvm.org
> > Reply To: parallel@lists.isocpp.org
> > Cc: peterz@infradead.org; j.alglave@ucl.ac.uk; will.deacon@arm.com;
> dhowells@redhat.com; Ramana.Radhakrishnan@arm.com; luc.maranget@inria.fr;
> akpm@linux-foundation.org; Peter.Sewell@cl.cam.ac.uk;
> torvalds@linux-foundation.org; mingo@kernel.org
> > Subject: [isocpp-parallel] Proposal for new memory_order_consume
> definition
> >
> > Hello!
> >
> > A proposal (quaintly identified as P0190R0) for a new
> memory_order_consume
> > definition may be found here:
> >
> > http://www2.rdrop.com/users/paulmck/submission/consume.2016.02.10b.pdf
> >
> > As requested at the October C++ Standards Committee meeting, this
> > is a follow-on to P0098R1 that picks one alternative and describes
> > it in detail. This approach focuses on existing practice, with the
> > goal of supporting existing code with existing compilers. In the last
> > clang/LLVM patch I saw for basic support of this change, you could coun=
t
> > the changed lines and still have lots of fingers and toes left over.
> > Those who have been following this story will recognize that this is
> > a very happy contrast to work that would be required to implement the
> > definition in the current standard.
> >
> > I expect that P0190R0 will be discussed at the upcoming C++ Standards
> > Committee meeting taking place the week of February 29th. Points of
> > discussion are likely to include:
> >
> > o     May memory_order_consume dependency ordering be used in
> > unannotated code? I believe that this must be the case,
> > especially given that this is our experience base. P0190R0
> > therefore recommends this approach.
> >
> > o     If memory_order_consume dependency ordering can be used in
> > unannotated code, must implementations support annotation?
> > I believe that annotation support should be required, at the very
> > least for formal verification, which can be quite difficult to
> > carry out on unannotated code. In addition, it seems likely
> > that annotations can enable much better diagnostics. P0190R0
> > therefore recommends this approach.
> >
> > o     If implementations must support annotation, what form should that
> > annotation take? P0190R0 recommends the [[carries_dependency]]
> > attribute, but I am not picky as long as it can be (1) applied
> > to all relevant pointer-like objects and (2) used in C as well
> > as C++. ;-)
> >
> > o     If memory_order_consume dependency ordering can be used in
> > unannotated code, how best to define the situations where
> > the compiler can determine the exact value of the pointer in
> > question? (In current defacto implementations, this can
> > defeat dependency ordering. Interestingly enough, this case
> > is not present in the Linux kernel, but still needs to be
> > defined.)
> >
> > Options include:
> >
> > o     Provide new intrinsics that carry out the
> > comparisons, but guarantee to preserve dependencies,
> > as recommended by P0190R0 (std::pointer_cmp_eq_dep(),
> > std::pointer_cmp_ne_dep(), std::pointer_cmp_gt_dep(),
> > std::pointer_cmp_ge_dep(), std::pointer_cmp_lt_dep(),
> > and std::pointer_cmp_le_dep()).
> >
> > o     State that -any- comparison involving an unannotated
> > pointer loses the dependency.
> >
> > o     How is the common idiom of marking pointers by setting low-order
> > bits to be supported when those pointers carry dependencies?
> > At the moment, I believe that setting bits in pointers results in
> > undefined behavior even without dependency ordering, so P0190R0
> > kicks this particular can down the road. One option that
> > has been suggested is to provide intrinsics for this purpose.
> > (Sorry, but I forget who suggested this.)
> >
> > Thoughts?
> >
> > Thanx, Paul
> >
> > _______________________________________________
> > Parallel mailing list
> > Parallel@lists.isocpp.org
> > Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
> > Link to this post: http://lists.isocpp.org/parallel/2016/02/0040.php
> > _______________________________________________
> > Parallel mailing list
> > Parallel@lists.isocpp.org
> > Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
> > Link to this post: http://lists.isocpp.org/parallel/2016/02/0045.php
>
> _______________________________________________
> Parallel mailing list
> Parallel@lists.isocpp.org
> Subscription: http://lists.isocpp.org/mailman/listinfo.cgi/parallel
> Link to this post: http://lists.isocpp.org/parallel/2016/02/0046.php

--001a113f92287bc435052ca1a22e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">If carries_dependency affects semantics, then it should no=
t be an attribute.<div><br></div><div>The original design, or at least my u=
nderstanding of it, was that it not have semantics; it was only a suggestio=
n to the compiler that it should preserve dependencies instead of inserting=
 a fence at the call site.=C2=A0 Dependency-based ordering would be preserv=
ed in either case.=C2=A0 But I think we&#39;re moving away from that view t=
owards something that doesn&#39;t quietly add fences.</div><div><br></div><=
div>I do not think we can quite get away with defining a dependency in a wa=
y that is unconditionally preserved by existing compilers, and thus I think=
 that we do probably need annotations along the dependency path.=C2=A0 I ju=
st don&#39;t see a way to otherwise deal with the case in which a compiler =
infers an equivalent pointer and dereferences that instead of the original.=
=C2=A0 This can happen under so many (unlikely but) hard-to-define conditio=
ns that it seems undefinable in an implementation-independent manner. &quot=
;If the implementation is able then &lt;the semantics change&gt;&quot; is, =
in my opinion, not acceptable standards text.</div><div><br></div><div>Thus=
 I see no way to both avoid adding syntax to functions that preserve depend=
encies and continue to allow existing transformations that remove dependenc=
ies we care about, e.g. due to equality comparisons.=C2=A0 We can hopefully=
 ensure that without annotations compilers break things with very low proba=
bility, so that there is a reasonable path forward for existing code relyin=
g on dependency ordering (which currently also breaks with very low probabi=
lity unless you understand what the compiler is doing).=C2=A0 But I don&#39=
;t see a way for the standard to guarantee correctness without the added sy=
ntax (or added optimization constraints that effectively assume all functio=
ns were annotated).</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Sat, Feb 20, 2016 at 11:53 AM, Paul E. McKenney <span dir=
=3D"ltr">&lt;<a href=3D"mailto:paulmck@linux.vnet.ibm.com" target=3D"_blank=
">paulmck@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><span class=3D"">On Fri, Feb 19, 2016 at 09:15:16PM -0500, Tony V=
 E wrote:<br>
&gt; There&#39;s at least one easy answer in there:<br>
&gt;<br>
&gt; &gt; =E2=80=8EIf implementations must support annotation, what form sh=
ould that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0annotation take?=C2=A0 P0190R0 recommends th=
e [[carries_dependency]]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0attribute, but I am not picky as long as it =
can be (1) applied<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0to all relevant pointer-like objects and (2)=
 used in C as well<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0as C++. =C2=A0;-)<br>
&gt;<br>
&gt; If an implementation must support it, then it is not an annotation but=
 a keyword. So no [[]]=C2=A0<br>
<br>
</span>I would be good with that approach, especially if the WG14 continues=
<br>
to stay away from annotations.<br>
<br>
For whatever it is worth, the introduction of intrinsics for comparisons<br=
>
that avoid breaking dependencies enables the annotation to remain<br>
optional.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Thanx, Paul<br>
<div><div class=3D"h5"><br>
&gt; Sent=C2=A0from=C2=A0my=C2=A0BlackBerry=C2=A0portable=C2=A0Babbage=C2=
=A0Device<br>
&gt; =C2=A0 Original Message =C2=A0<br>
&gt; From: Paul E. McKenney<br>
&gt; Sent: Thursday, February 18, 2016 4:58 AM<br>
&gt; To: <a href=3D"mailto:parallel@lists.isocpp.org">parallel@lists.isocpp=
.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel@vger=
.kernel.org</a>; <a href=3D"mailto:linux-arch@vger.kernel.org">linux-arch@v=
ger.kernel.org</a>; <a href=3D"mailto:gcc@gcc.gnu.org">gcc@gcc.gnu.org</a>;=
 <a href=3D"mailto:llvm-dev@lists.llvm.org">llvm-dev@lists.llvm.org</a><br>
&gt; Reply To: <a href=3D"mailto:parallel@lists.isocpp.org">parallel@lists.=
isocpp.org</a><br>
&gt; Cc: <a href=3D"mailto:peterz@infradead.org">peterz@infradead.org</a>; =
<a href=3D"mailto:j.alglave@ucl.ac.uk">j.alglave@ucl.ac.uk</a>; <a href=3D"=
mailto:will.deacon@arm.com">will.deacon@arm.com</a>; <a href=3D"mailto:dhow=
ells@redhat.com">dhowells@redhat.com</a>; <a href=3D"mailto:Ramana.Radhakri=
shnan@arm.com">Ramana.Radhakrishnan@arm.com</a>; <a href=3D"mailto:luc.mara=
nget@inria.fr">luc.maranget@inria.fr</a>; <a href=3D"mailto:akpm@linux-foun=
dation.org">akpm@linux-foundation.org</a>; <a href=3D"mailto:Peter.Sewell@c=
l.cam.ac.uk">Peter.Sewell@cl.cam.ac.uk</a>; <a href=3D"mailto:torvalds@linu=
x-foundation.org">torvalds@linux-foundation.org</a>; <a href=3D"mailto:ming=
o@kernel.org">mingo@kernel.org</a><br>
&gt; Subject: [isocpp-parallel] Proposal for new memory_order_consume defin=
ition<br>
&gt;<br>
&gt; Hello!<br>
&gt;<br>
&gt; A proposal (quaintly identified as P0190R0) for a new memory_order_con=
sume<br>
&gt; definition may be found here:<br>
&gt;<br>
&gt; <a href=3D"http://www2.rdrop.com/users/paulmck/submission/consume.2016=
.02.10b.pdf" rel=3D"noreferrer" target=3D"_blank">http://www2.rdrop.com/use=
rs/paulmck/submission/consume.2016.02.10b.pdf</a><br>
&gt;<br>
&gt; As requested at the October C++ Standards Committee meeting, this<br>
&gt; is a follow-on to P0098R1 that picks one alternative and describes<br>
&gt; it in detail. This approach focuses on existing practice, with the<br>
&gt; goal of supporting existing code with existing compilers. In the last<=
br>
&gt; clang/LLVM patch I saw for basic support of this change, you could cou=
nt<br>
&gt; the changed lines and still have lots of fingers and toes left over.<b=
r>
&gt; Those who have been following this story will recognize that this is<b=
r>
&gt; a very happy contrast to work that would be required to implement the<=
br>
&gt; definition in the current standard.<br>
&gt;<br>
&gt; I expect that P0190R0 will be discussed at the upcoming C++ Standards<=
br>
&gt; Committee meeting taking place the week of February 29th. Points of<br=
>
&gt; discussion are likely to include:<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0May memory_order_consume dependency ordering be u=
sed in<br>
&gt; unannotated code? I believe that this must be the case,<br>
&gt; especially given that this is our experience base. P0190R0<br>
&gt; therefore recommends this approach.<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0If memory_order_consume dependency ordering can b=
e used in<br>
&gt; unannotated code, must implementations support annotation?<br>
&gt; I believe that annotation support should be required, at the very<br>
&gt; least for formal verification, which can be quite difficult to<br>
&gt; carry out on unannotated code. In addition, it seems likely<br>
&gt; that annotations can enable much better diagnostics. P0190R0<br>
&gt; therefore recommends this approach.<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0If implementations must support annotation, what =
form should that<br>
&gt; annotation take? P0190R0 recommends the [[carries_dependency]]<br>
&gt; attribute, but I am not picky as long as it can be (1) applied<br>
&gt; to all relevant pointer-like objects and (2) used in C as well<br>
&gt; as C++. ;-)<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0If memory_order_consume dependency ordering can b=
e used in<br>
&gt; unannotated code, how best to define the situations where<br>
&gt; the compiler can determine the exact value of the pointer in<br>
&gt; question? (In current defacto implementations, this can<br>
&gt; defeat dependency ordering. Interestingly enough, this case<br>
&gt; is not present in the Linux kernel, but still needs to be<br>
&gt; defined.)<br>
&gt;<br>
&gt; Options include:<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0Provide new intrinsics that carry out the<br>
&gt; comparisons, but guarantee to preserve dependencies,<br>
&gt; as recommended by P0190R0 (std::pointer_cmp_eq_dep(),<br>
&gt; std::pointer_cmp_ne_dep(), std::pointer_cmp_gt_dep(),<br>
&gt; std::pointer_cmp_ge_dep(), std::pointer_cmp_lt_dep(),<br>
&gt; and std::pointer_cmp_le_dep()).<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0State that -any- comparison involving an unannota=
ted<br>
&gt; pointer loses the dependency.<br>
&gt;<br>
&gt; o=C2=A0 =C2=A0 =C2=A0How is the common idiom of marking pointers by se=
tting low-order<br>
&gt; bits to be supported when those pointers carry dependencies?<br>
&gt; At the moment, I believe that setting bits in pointers results in<br>
&gt; undefined behavior even without dependency ordering, so P0190R0<br>
&gt; kicks this particular can down the road. One option that<br>
&gt; has been suggested is to provide intrinsics for this purpose.<br>
&gt; (Sorry, but I forget who suggested this.)<br>
&gt;<br>
&gt; Thoughts?<br>
&gt;<br>
&gt; Thanx, Paul<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Parallel mailing list<br>
&gt; <a href=3D"mailto:Parallel@lists.isocpp.org">Parallel@lists.isocpp.org=
</a><br>
&gt; Subscription: <a href=3D"http://lists.isocpp.org/mailman/listinfo.cgi/=
parallel" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.org/mail=
man/listinfo.cgi/parallel</a><br>
&gt; Link to this post: <a href=3D"http://lists.isocpp.org/parallel/2016/02=
/0040.php" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.org/par=
allel/2016/02/0040.php</a><br>
&gt; _______________________________________________<br>
&gt; Parallel mailing list<br>
&gt; <a href=3D"mailto:Parallel@lists.isocpp.org">Parallel@lists.isocpp.org=
</a><br>
&gt; Subscription: <a href=3D"http://lists.isocpp.org/mailman/listinfo.cgi/=
parallel" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.org/mail=
man/listinfo.cgi/parallel</a><br>
&gt; Link to this post: <a href=3D"http://lists.isocpp.org/parallel/2016/02=
/0045.php" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.org/par=
allel/2016/02/0045.php</a><br>
<br>
_______________________________________________<br>
Parallel mailing list<br>
<a href=3D"mailto:Parallel@lists.isocpp.org">Parallel@lists.isocpp.org</a><=
br>
Subscription: <a href=3D"http://lists.isocpp.org/mailman/listinfo.cgi/paral=
lel" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.org/mailman/l=
istinfo.cgi/parallel</a><br>
</div></div>Link to this post: <a href=3D"http://lists.isocpp.org/parallel/=
2016/02/0046.php" rel=3D"noreferrer" target=3D"_blank">http://lists.isocpp.=
org/parallel/2016/02/0046.php</a></blockquote></div><br></div>

--001a113f92287bc435052ca1a22e--

--===============5891289396364423272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTExWTSBEZXZl
bG9wZXJzIG1haWxpbmcgbGlzdApsbHZtLWRldkBsaXN0cy5sbHZtLm9yZwpodHRwOi8vbGlzdHMu
bGx2bS5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2xsdm0tZGV2Cg==

--===============5891289396364423272==--
