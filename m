From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 07:27:12 -0800
Message-ID: <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=94eb2c04abb8f9f4dc054272384b
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Sender: linus971@gmail.com
In-Reply-To: <20161129135118.24696-1-kilobyte@angband.pl>
Resent-Message-ID: <EEOM90trJIE.A.eaG.FKaPYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

--94eb2c04abb8f9f4dc054272384b
Content-Type: text/plain; charset=UTF-8

On Nov 29, 2016 5:51 AM, "Adam Borowski" <kilobyte@angband.pl> wrote:
>

> >
> >  (a) tested
>
> By many people.

No.

I've tested the build *without* this, and it works fine.

> >  (b) explains it
>
> The actual logic is in 4efca4ed0.  It wants C prototypes defined in
> asm/asm-prototypes.h that lists symbols defined in assembly -- genksyms
> knows only how to read C code.

See above. I'm not taking more random patches that "fix" this when it's not
broken for me. Not without very explicit explanations of why that patch is
still needed for others.

I suspect one of the other patches already fixed is for x86.

     Linus

--94eb2c04abb8f9f4dc054272384b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 29, 2016 5:51 AM, &quot;Adam Borowski&quot; &lt;<a hr=
ef=3D"mailto:kilobyte@angband.pl">kilobyte@angband.pl</a>&gt; wrote:<br>
&gt;</p>
<p dir=3D"ltr">&gt; &gt;<br>
&gt; &gt;=C2=A0 (a) tested<br>
&gt;<br>
&gt; By many people.</p>
<p dir=3D"ltr">No. </p>
<p dir=3D"ltr">I&#39;ve tested the build *without* this, and it works fine.=
</p>
<p dir=3D"ltr">&gt; &gt;=C2=A0 (b) explains it<br>
&gt;<br>
&gt; The actual logic is in 4efca4ed0.=C2=A0 It wants C prototypes defined =
in<br>
&gt; asm/asm-prototypes.h that lists symbols defined in assembly -- genksym=
s<br>
&gt; knows only how to read C code.</p>
<p dir=3D"ltr">See above. I&#39;m not taking more random patches that &quot=
;fix&quot; this when it&#39;s not broken for me. Not without very explicit =
explanations of why that patch is still needed for others.</p>
<p dir=3D"ltr">I suspect one of the other patches already fixed is for x86.=
</p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0 Linus<br>
</p>

--94eb2c04abb8f9f4dc054272384b--
