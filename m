From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC v3 00/13] linux: generalize sections,
	ranges and linker tables
Date: Tue, 9 Aug 2016 21:51:13 -0700
Message-ID: <CALCETrVmDhPC6BMu4_xTanSFZBKeW9V6A4SeQ4qxnpVod-eLbQ@mail.gmail.com>
References: <1469222687-1600-1-git-send-email-mcgrof@kernel.org>
 <20160809152429.5bb1c077@lxorguk.ukuu.org.uk>
 <1470758947.2299.47.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4245753166950360238=="
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1470758947.2299.47.camel@HansenPartnership.com>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org, realmz6@gmail.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, ming.lei@canonical.com, heiko.carstens@de.ibm.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, fontana@sharpeleven.org, mingo@redhat.com, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, mhiramat@kernel.org, rusty@rustcorp.com.au, keescook@chromium.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, will.deacon@arm.com, pali.rohar@gmail.com, rostedt@goodmis.org, christopher.denicolo@suse.com, jbaron@akamai.com, ananth@linux.vnet.ibm.com, ciaran.farrell@suse.
List-Id: linux-arch.vger.kernel.org

--===============4245753166950360238==
Content-Type: multipart/alternative; boundary=94eb2c125290335bf30539b06628

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


--===============4245753166950360238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KWGVuLWRldmVs
IG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMueGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5v
cmcveGVuLWRldmVsCg==

--===============4245753166950360238==--
