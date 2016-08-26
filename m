From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core
	helpers
Date: Thu, 25 Aug 2016 23:38:44 -0700
Message-ID: <CAB=NE6UQ8qE6AqRg9=YddNYrMyU7opCEij-5Usty7wMgEJJbpw@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642454-5679-5-git-send-email-mcgrof@kernel.org>
 <20160823112633.7d482e62@roar.ozlabs.ibm.com>
 <20160823173306.GA3296@wotan.suse.de>
 <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
 <20160824201253.GS3296@wotan.suse.de>
 <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
 <20160825060540.GX3296@wotan.suse.de>
 <20160825165121.45d26fb0@roar.ozlabs.ibm.com>
 <20160825175239.GB3296@wotan.suse.de>
 <20160826130024.0ad51d33@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0114640604885045811=="
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20160826130024.0ad51d33@roar.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, realmz6@gmail.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@hansenpartnership.com, jcmvbkbc@gmail.com, paulus@samba.org, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, msalter@redhat.com, davem@davemloft.net, mpe@ellerman.id.au, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, mhiramat@kernel.org, linux-xtensa@linux-xtensa.org, rusty@rustcorp.com.au, keescook@chromium.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, jani.nikula@int
List-Id: linux-arch.vger.kernel.org

--===============0114640604885045811==
Content-Type: multipart/alternative; boundary=001a114db10c30f2dc053af3c4d7

--001a114db10c30f2dc053af3c4d7
Content-Type: text/plain; charset=UTF-8

On Aug 25, 2016 8:00 PM, "Nicholas Piggin" <npiggin@gmail.com> wrote:
>
> On Thu, 25 Aug 2016 19:52:39 +0200
> "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
>
> > On Thu, Aug 25, 2016 at 04:51:21PM +1000, Nicholas Piggin wrote:
> > > On Thu, 25 Aug 2016 08:05:40 +0200
> > > "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> > > > > Oh, that makes more sense. The SECTION stuff and custom sections
was
> > > > > confusing me. I would prefer just to drop all the LINUX_SECTION
naming
> > > > > and make it match the functionality you're using. For example:
> > > > >
> > > > > +DEFINE_LINKTABLE(struct jump_entry, __jump_table);
> > > > > +
> > > > >  /* mutex to protect coming/going of the the jump_label table */
> > > > >  static DEFINE_MUTEX(jump_label_mutex);
> > > > >
> > > > > @@ -274,8 +277,6 @@ static void __jump_label_update(struct
static_key *key,
> > > > >
> > > > >  void __init jump_label_init(void)
> > > > >  {
> > > > > -       struct jump_entry *iter_start = __start___jump_table;
> > > > > -       struct jump_entry *iter_stop = __stop___jump_table;
> > > > >         struct static_key *key = NULL;
> > > > >         struct jump_entry *iter;
> > > > >
> > > > > @@ -292,9 +293,10 @@ void __init jump_label_init(void)
> > > > >                 return;
> > > > >
> > > > >         jump_label_lock();
> > > > > -       jump_label_sort_entries(iter_start, iter_stop);
> > > > > +       jump_label_sort_entries(LINUX_SECTION_START(__jump_table),
> > > > > +                               LINUX_SECTION_END(__jump_table));
> > > > >
> > > > > Now I think this is a fine abstraction to have.
> > > >
> > > > OK will keep this one.
> > > >
> > > > > I think it would look
> > > > > even cleaner if you had:
> > > > >
> > > > > LINKTABLE_START(__jump_table)
> > > > > LINKTABLE_END(__jump_table)
> > > > >
> > > > > Then do we need to even have the LINUX_SECTION middle man at all?
> > > >
> > > > Ah, thing is we use this for both linktables and section ranges.
> > > > Or do we want macros for both that do the same thing ?
> > >
> > > I think it would make the code using it more readable.
> >
> > Alrighty... so:
> >
> > LINKTABLE_START()
> > LINKTABLE_END()
> >
> > SECTION_RANGE_START()
> > SECTION_RANGE_END()
> >
> > And these macros do the exact same thing. Ie, nothing shared. Right?
>
> Yeah I think so. Internally they would probably be aliased to the
> same common definition (unless you had some type check or something),
> but user would know about such details.

What name should we use for such common macro definition ?

  Luis

--001a114db10c30f2dc053af3c4d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Aug 25, 2016 8:00 PM, &quot;Nicholas Piggin&quot; &lt;<a =
href=3D"mailto:npiggin@gmail.com">npiggin@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Thu, 25 Aug 2016 19:52:39 +0200<br>
&gt; &quot;Luis R. Rodriguez&quot; &lt;<a href=3D"mailto:mcgrof@kernel.org"=
>mcgrof@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Thu, Aug 25, 2016 at 04:51:21PM +1000, Nicholas Piggin wrote:<=
br>
&gt; &gt; &gt; On Thu, 25 Aug 2016 08:05:40 +0200<br>
&gt; &gt; &gt; &quot;Luis R. Rodriguez&quot; &lt;<a href=3D"mailto:mcgrof@k=
ernel.org">mcgrof@kernel.org</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; Oh, that makes more sense. The SECTION stuff and c=
ustom sections was<br>
&gt; &gt; &gt; &gt; &gt; confusing me. I would prefer just to drop all the =
LINUX_SECTION naming<br>
&gt; &gt; &gt; &gt; &gt; and make it match the functionality you&#39;re usi=
ng. For example:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; +DEFINE_LINKTABLE(struct jump_entry, __jump_table)=
;<br>
&gt; &gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 /* mutex to protect coming/going of the the =
jump_label table */<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 static DEFINE_MUTEX(jump_label_mutex);<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; @@ -274,8 +277,6 @@ static void __jump_label_updat=
e(struct static_key *key,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 void __init jump_label_init(void)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct jump_entry *ite=
r_start =3D __start___jump_table;<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct jump_entry *ite=
r_stop =3D __stop___jump_table;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct static_key=
 *key =3D NULL;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct jump_entry=
 *iter;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; @@ -292,9 +293,10 @@ void __init jump_label_init(v=
oid)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0jump_label_lock()=
;<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0jump_label_sort_entrie=
s(iter_start, iter_stop);<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0jump_label_sort_entrie=
s(LINUX_SECTION_START(__jump_table),<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LINUX_SECTION=
_END(__jump_table));<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Now I think this is a fine abstraction to have.<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; OK will keep this one.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I think it would look<br>
&gt; &gt; &gt; &gt; &gt; even cleaner if you had:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; LINKTABLE_START(__jump_table)<br>
&gt; &gt; &gt; &gt; &gt; LINKTABLE_END(__jump_table)<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Then do we need to even have the LINUX_SECTION mid=
dle man at all?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Ah, thing is we use this for both linktables and sectio=
n ranges.<br>
&gt; &gt; &gt; &gt; Or do we want macros for both that do the same thing ?<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I think it would make the code using it more readable.<br>
&gt; &gt;<br>
&gt; &gt; Alrighty... so:<br>
&gt; &gt;<br>
&gt; &gt; LINKTABLE_START()<br>
&gt; &gt; LINKTABLE_END()<br>
&gt; &gt;<br>
&gt; &gt; SECTION_RANGE_START()<br>
&gt; &gt; SECTION_RANGE_END()<br>
&gt; &gt;<br>
&gt; &gt; And these macros do the exact same thing. Ie, nothing shared. Rig=
ht?<br>
&gt;<br>
&gt; Yeah I think so. Internally they would probably be aliased to the<br>
&gt; same common definition (unless you had some type check or something),<=
br>
&gt; but user would know about such details.</p>
<p dir=3D"ltr">What name should we use for such common macro definition ?</=
p>
<p dir=3D"ltr">=C2=A0 Luis</p>

--001a114db10c30f2dc053af3c4d7--


--===============0114640604885045811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVs
IG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5v
cmcveGVuLWRldmVsCg==

--===============0114640604885045811==--
