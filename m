From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support 'COMPILE_TEST' in 'asm-generic'.
Date: Fri, 5 Jul 2013 13:13:43 +0200
Message-ID: <201307051313.43491.arnd@arndb.de>
References: <20130704011221.GA11230@kroah.com> <51D617E9.8080907@gmail.com> <51D67D6C.4080603@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51D67D6C.4080603@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
Cc: Chen Gang <gang.chen@asianux.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Friday 05 July 2013, Chen Gang F T wrote:
> Hello All:
> 
> It seems 'asm-generic' dislikes 'mad users' (e.g allmodconfig,
> randconfig, and me).
> 
> I guess the main reason is: 'asm-generic' thinks what mad users talk
> about is useless in real world, so it is just noisy.
> 
> I can understand, at least what I talk about is not for urgent things.
> (maybe 'asm-generic' also thinks it not important either, every members
> have their own opinions).
> 
> Next, I still use allmodconfig/randconfig for some architectures which I
> am interested in (and also for learning compilers), but I will skip all
> things which are related with 'asm-generic', since it dislikes me (a mad
> user).

As the asm-generic maintainer I think I have to clarify a few things:

* Build-time fixes for warnings and randconfig errors are good,
  and you have sent a number of good bug fixes all over the kernel,
  I definitely welcome getting more of those. In many cases the
  fix is trivial and obvious, in other cases you need to know
  much more of the background to understand what the underlying
  problem is and why you should not just fix the symptom.

* You have made an (understandable) mistake with this particular
  patch. It would have been nice if you had not made it, but I
  can see that you are still learning about these things. There
  is a fine line between what makes sense to be enabled as a
  'compile test' and what should better be left disabled by
  Kconfig.

* When experienced developers tell you that you are mistaken, you
  need to make an effort to understand what the mistake was so you
  can learn from it and not make the same mistake again. If you
  make the same mistakes again, maintainers will get annoyed and
  ignore you (or worse), which is not a good situation to be
  in when you want to get your patches merged.

	Arnd
