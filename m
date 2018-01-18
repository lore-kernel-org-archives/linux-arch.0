From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 00/36] Andes(nds32) Linux Kernel Port
Date: Thu, 18 Jan 2018 10:49:48 +0100
Message-ID: <CAK8P3a2y3vtmtPLTsty6VEvK5oWG0yhfrXCea+vY9HqJQot8pA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This is the 6th version patchset to add the Linux kernel port for Andes(nds32)
> processors. Almost all of the feedbacks from v5 patchseries has been addressed.
> Thanks to everyone who provided feedback on the previous version.
>
>
> This patchset adds core architecture support to Linux for Andestech's
> N13, N15, D15, N10, D10 processor cores.
>
> Based on the 16/32-bit AndeStar RISC-like architecture, we designed the
> configurable AndesCore series of embedded processor families. AndesCores
> range from highly performance-efficient small-footprint cores for
> microcontrollers and deeply-embedded applications to 1GHz+ cores running
> Linux, covering general-purpose N-series cores for a wide range of computing
> need, DSP-capable D-series cores for digital signal control,
> instruction-extensible E-series cores for application-specific acceleration,
> and secure S-series cores for best protection of the most valuable.
>
> The patches are based on v4.14-rc8, and can also be found in the
> following git tree:
>   https://github.com/andestech/linux.git nds32-4.14-rc8-v6
>
> The build script and toolchain repositories are able to be found here:
>   https://github.com/andestech/build_script.git
>
> Freely available instruction set and architecture overview documents can
> be found on the following page:
>   http://www.andestech.com/product.php?cls=9
>
>
> Vincent Ren-Wei Chen and I will maintain this port. Thanks to everyone who
> helped us and contributed to it. :) Any feedback is welcome.

Hi Greentime,

I think it's time to move this to the next step towards inclusion, as you appear
to have addressed all major issues, and only smaller details remain.

This is what I'd suggest for moving forward:

- split the patches into two branches in git: one 'next' branch for
everything that
  is ready to get merged in one pull request that you send to Linus, including
  drivers that you have received an Ack for from the respective subsystem
  maintainers, and one 'testing' branch for anything that is either
not quite ready
  or that you expect to get merged through someone else's tree (e.g.
  most device drivers). The 'testing' branch can merge in the 'next' branch
  or get rebased on it frequently.

- Ask reviewers to send 'Acked-by' or 'Reviewed-by' tags for the patches they
  are happy with, or to complain if they still see any major issues that
  should prevent the series from going in. I'll go through the submission once
  more myself and Ack any patches that I have actually reviewed.

- Decide what base to use for the 'next' branch, rebase it on that release one
  more time and then plan to never rebase it again. This will be the branch
  to send to linux-next and to Linus Torvalds. Given the current timing of the
  merge window, I would suggest to base it on top of v4.16-rc1 once that
  gets released, and then send it for inclusion in 4.17. Any changes you do
  in the meantime would be added on top of the original set.

- Ask Stephen Rothwell to include your 'next' branch in linux-next.
  (if you base on 4.16-rc1, wait until that is out).

- Submit any remaining driver patches that you do not have an 'Ack' for to
  the respective subsystem maintainers for inclusion in their trees.

- Upload a gpg key (4096 bits) for your greentime@andestech.com address
  to the keyservers, and arrange to have that signed by other kernel
  developers. You will need to sign git tags for pull requests with your
  key, and the key itself should be signed for this to work best.

- Once you have at least three signatures on your gpg key, apply for
  an account on kernel.org and move your git tree there,
  see https://www.kernel.org/category/faq.html. Alternatively,
  host the git tree on a web-facing git server from andestech.com
  (github works initially, but has a couple of shortcomings).

         Arnd
