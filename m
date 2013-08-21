From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Get rid of SUBARCH
Date: Wed, 21 Aug 2013 14:58:04 +0200
Message-ID: <7813eeb3-8f96-4d3d-87ec-f2a880122804@email.android.com>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Thorsten Glaser <t.glaser@tarent.de>, Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

If ARCH doesn't match uname for some definition of match?

Thorsten Glaser <t.glaser@tarent.de> wrote:
>On Wed, 21 Aug 2013, Richard Weinberger wrote:
>
>> The series touches also m68k, sh, mips and unicore32.
>> These architectures magically select a cross compiler if ARCH !=3D
>SUBARCH.
>> Do really need that behavior?
>
>Not precisely that, but it=E2=80=99s very common in m68k land
>to just cross-build kernels with
>
>$ make ARCH=3Dm68k menuconfig
>$ make ARCH=3Dm68k
>
>Maybe a generalising of that feature, and making it
>independent of SUBARCH (which can then die)?
>
>bye,
>//mirabilos

--=20
Sent from my mobile phone. Please excuse brevity and lack of formatting=
=2E
