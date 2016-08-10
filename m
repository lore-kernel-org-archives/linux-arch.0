Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <1470758947.2299.47.camel@HansenPartnership.com>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160809152429.5bb1c077@lxorguk.ukuu.org.uk> <1470758947.2299.47.camel@HansenPartnership.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 9 Aug 2016 21:51:13 -0700
Message-ID: <CALCETrVmDhPC6BMu4_xTanSFZBKeW9V6A4SeQ4qxnpVod-eLbQ@mail.gmail.com>
Subject: Re: [RFC v3 00/13] linux: generalize sections, ranges and linker tables
Content-Type: multipart/alternative; boundary=94eb2c125290335bf30539b06628
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: benh@kernel.crashing.org, masami.hiramatsu.pt@hitachi.com, linux@rasmusvillemoes.dk, linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dwmw2@infradead.org, xen-devel@lists.xensource.com, "Luis R. Rodriguez" <mcgrof@kernel.org>, anil.s.keshavamurthy@intel.com, will.deacon@arm.com, linux-ia64@vger.kernel.org, x86@kernel.org, korea.drzix@gmail.com, mingo@redhat.com, andrew.cooper3@citrix.com, jgross@suse.com, tglx@linutronix.de, keescook@chromium.org, ananth@linux.vnet.ibm.com, jpoimboe@redhat.com, rostedt@goodmis.org, hpa@zytor.com, arnd@arndb.de, davem@davemloft.net, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, platform-driver-x86@vger.kernel.org, jkosina@suse.cz, david.vrabel@citrix.com, realmz6@gmail.com, fontana@sharpeleven.org, konrad.wilk@oracle.com, ananth@in.ibm.com, paul.gortmaker@windriver.com, pali.rohar@gmail.com, ak@linux.intel.com, pebolle@tiscali.nl, jbaron@akamai.com, mmarek@suse.com, rusty@rustcorp.com.au, tony.luck@intel.com, catalin.marinas@arm.com, dvhart@infradead.org, linux-arm-kernel@lists.infradead.org, ming.lei@canonical.com, linux@arm.linux.org.uk, andriy.shevchenko@linux.intel.com, christopher.denicolo@suse.com, linux-arch@vger.kernel.org, mcb30@ipxe.org, heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org, mhiramat@kernel.org, ciaran.farrell@suse.com, bp@alien8.de, sparclinux@vger.kernel.org, alan@linux.intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20160810045113.8W45uKd5lnycOolk9iDS2cgJluCH6MoPu0ityFEWbNA@z>

--94eb2c125290335bf30539b06628
Content-Type: text/plain; charset=UTF-8

On Aug 9, 2016 7:09 PM, "James Bottomley" <
James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2016-08-09 at 15:24 +0100, One Thousand Gnomes wrote:
> > > table development go under copyleft-next, Rusty recently asked for
> > > code to go in prior to the license tag being added denoting this
> > > license as GPL-compatible [3] -- I had noted in the patch
> > > submission which annotated copyleft-next's compatibility to GPLv2
> > > that copyleft-next is the license of choice for ongoing kernel
> > > development on my end [4]. If this is objectionable I'm happy to
> > > change it to GPLv2 however I'd like a reason provided as I've gone
> > > through all possible channels to ensure this is kosher, including
> > > vetting by 3 attorneys now, 2 at SUSE.
> >
> > You don't need a new tag, you can use "GPL" or "GPL and additional
> > rights". In fact you don't want any other tag because when combined
> >  with the kernel it is GPLv2 anyway because the only way the two are
> > fully compatible is for the kernel community to license the derived
> > work under the GPL.
>
> This is the module tag ... it says what licence the module is under,
> not the licence for the module combined with the kernel, which is
> always GPLv2 because the stricter licence rules.

Then why isn't "BSD" in the license_is_gpl_compatible list?

--94eb2c125290335bf30539b06628
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Aug 9, 2016 7:09 PM, &quot;James Bottomley&quot; &lt;<a h=
ref=3D"mailto:James.Bottomley@hansenpartnership.com">James.Bottomley@hansen=
partnership.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, 2016-08-09 at 15:24 +0100, One Thousand Gnomes wrote:<br>
&gt; &gt; &gt; table development go under copyleft-next, Rusty recently ask=
ed for<br>
&gt; &gt; &gt; code to go in prior to the license tag being added denoting =
this<br>
&gt; &gt; &gt; license as GPL-compatible [3] -- I had noted in the patch<br=
>
&gt; &gt; &gt; submission which annotated copyleft-next&#39;s compatibility=
 to GPLv2<br>
&gt; &gt; &gt; that copyleft-next is the license of choice for ongoing kern=
el<br>
&gt; &gt; &gt; development on my end [4]. If this is objectionable I&#39;m =
happy to<br>
&gt; &gt; &gt; change it to GPLv2 however I&#39;d like a reason provided as=
 I&#39;ve gone<br>
&gt; &gt; &gt; through all possible channels to ensure this is kosher, incl=
uding<br>
&gt; &gt; &gt; vetting by 3 attorneys now, 2 at SUSE.<br>
&gt; &gt;<br>
&gt; &gt; You don&#39;t need a new tag, you can use &quot;GPL&quot; or &quo=
t;GPL and additional<br>
&gt; &gt; rights&quot;. In fact you don&#39;t want any other tag because wh=
en combined<br>
&gt; &gt;=C2=A0 with the kernel it is GPLv2 anyway because the only way the=
 two are<br>
&gt; &gt; fully compatible is for the kernel community to license the deriv=
ed<br>
&gt; &gt; work under the GPL.<br>
&gt;<br>
&gt; This is the module tag ... it says what licence the module is under,<b=
r>
&gt; not the licence for the module combined with the kernel, which is<br>
&gt; always GPLv2 because the stricter licence rules.</p>
<p dir=3D"ltr">Then why isn&#39;t &quot;BSD&quot; in the license_is_gpl_com=
patible list?</p>

--94eb2c125290335bf30539b06628--
