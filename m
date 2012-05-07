From: Tony Luck <tony.luck@gmail.com>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Mon, 7 May 2012 16:15:44 -0700
Message-ID: <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com>
References: <20120428205651.GA7426@merkur.ravnborg.org>
	<20120428205919.GC7442@merkur.ravnborg.org>
	<4FA460AB.6060309@suse.cz>
	<20120505082916.GA14006@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20120505082916.GA14006@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <mmarek@suse.cz>, linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

This patch is now in linux-next (tag next-20120507). But it looks to have
broken the ia64 build. I see this error:

  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
ld: .tmp_kallsyms1.o: linking constant-gp files with non-constant-gp files
ld: failed to merge target specific data of file .tmp_kallsyms1.o
make: *** [vmlinux] Error 1

which looks like we used the wrong compile options when building
.tmp_kallsyms1.o

-Tony
