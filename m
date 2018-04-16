From: Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH v3] mm/page_owner: ignore everything below the IRQ entry
 point
Date: Mon, 16 Apr 2018 11:14:59 +0530
Message-ID: <20180416054459epcms5p85f343635408abccfd12080d7fc322911@epcms5p8>
References: <201803272356.6XjvciDF%fengguang.wu@intel.com>
        <1522150907-33547-1-git-send-email-maninder1.s@samsung.com>
        <CGME20180327160057epcas5p30597e515a359dc6a5d54767a8bcb78a7@epcms5p8>
Reply-To: maninder1.s@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201803272356.6XjvciDF%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "dvyukov@google.com" <dvyukov@google.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>, "glider@google.com" <glider@google.com>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "pombredanne@nexb.com" <pombredanne@nexb.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "mhocko@suse.com" <mhocko@suse.com>, "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>, "gomonovych@gmail.com" <gomonovych@gmail.com>, Ayush Mittal <ayush.m@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>A
List-Id: linux-arch.vger.kernel.org

=C2=A0=0D=0AHi=20Arnd,=0D=0A=0D=0A=0D=0AWe=20sent=20one=20patch=20for=20ign=
oring=20entries=20below=20IRQ=20point=20in=20page_onwer=20using=20stackdepo=
t.=0D=0A=0D=0AV2:-=20https://lkml.org/lkml/2018/3/26/178=0D=0A=0D=0AV3:-=20=
https://lkml.org/lkml/2018/3/27/357=0D=0A=0D=0ABut=20it's=20breaking=20buil=
d=20for=20um=20target=20with=20below=20reason.=0D=0A=0D=0A=0D=0A=C2=A0=C2=
=A0=C2=A0kernel/stacktrace.o:=C2=A0In=C2=A0function=C2=A0=60filter_irq_stac=
ks':=0D=0A>>=C2=A0stacktrace.c:(.text+0x20e):=C2=A0undefined=C2=A0reference=
=C2=A0to=C2=A0=60__irqentry_text_start'=0D=0A>>=C2=A0stacktrace.c:(.text+0x=
218):=C2=A0undefined=C2=A0reference=C2=A0to=C2=A0=60__irqentry_text_end'=0D=
=0A>>=C2=A0stacktrace.c:(.text+0x222):=C2=A0undefined=C2=A0reference=C2=A0t=
o=C2=A0=60__softirqentry_text_start'=0D=0A>>=C2=A0stacktrace.c:(.text+0x22c=
):=C2=A0undefined=C2=A0reference=C2=A0to=C2=A0=60__softirqentry_text_end'=
=0D=0A=C2=A0=C2=A0=C2=A0collect2:=C2=A0error:=C2=A0ld=C2=A0returned=C2=A01=
=C2=A0exit=C2=A0status=0D=0A=0D=0ASo=20can=20we=20add=20below=20fix=20for=
=20this=20build=20break,=20can=20you=20suggest=20if=20it=20is=20ok=20or=20w=
e=20need=20to=20find=0D=0Asome=20other=20way:-=0D=0A=0D=0Adiff=20--git=20a/=
include/asm-generic/vmlinux.lds.h=20b/include/asm-generic/vmlinux.lds.h=0D=
=0Aindex=2076b63f5..0f3b7f8=20100644=0D=0A---=20a/include/asm-generic/vmlin=
ux.lds.h=0D=0A+++=20b/include/asm-generic/vmlinux.lds.h=0D=0A=40=40=20-460,=
6=20+460,10=20=40=40=0D=0A=20=20*=20to=20use=20=22..=22=20first.=0D=0A=20=
=20*/=0D=0A=20=23define=20TEXT_TEXT=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__irqentry_text_start)=20=3D=
=20.;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__irqentry_text_end)=20=3D=20.;=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__softirqentry_text_start)=20=
=3D=20.;=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20VMLINUX_SYMBOL(__softirqentry_text_end)=20=3D=20.;=20=20=
=20=20=20=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20ALIGN_FUNCTION();=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*(.text.hot=20TEXT_MA=
IN=20.text.fixup=20.text.unlikely)=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20*(.text..refcount)=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=5C=0D=0Adiff=20--git=20a/include/linux/kallsyms.h=20b=
/include/linux/kallsyms.h=0D=0A=0D=0A=0D=0ATo=20make=20solution=20generic=
=20for=20all=20architecture=20we=20declared=204=20dummy=20variables=20which=
=20we=20used=20in=20our=20patch.=0D=0A=0D=0A=0D=0AThanks=20,=0D=0AManinder=
=20Singh
