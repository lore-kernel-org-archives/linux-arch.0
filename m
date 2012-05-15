From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Wed, 16 May 2012 00:20:10 +0200
Message-ID: <20120515222010.GB9277@pobox.suse.cz>
References: <20120428205651.GA7426@merkur.ravnborg.org> <20120428205919.GC7442@merkur.ravnborg.org> <4FA460AB.6060309@suse.cz> <20120505082916.GA14006@merkur.ravnborg.org> <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com> <20120508165118.GA11750@merkur.ravnborg.org> <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com> <20120510122210.GA17550@sepie.suse.cz> <4FABD436.7070402@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FABD436.7070402@windriver.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Tony Luck <tony.luck@gmail.com>, linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>, ralf@linux-mips.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 10, 2012 at 10:44:06AM -0400, Paul Gortmaker wrote:
> On 12-05-10 08:22 AM, Michal Marek wrote:
> > I think it should be as simple as the below patch. But I have no mips
> > machine to verify myself.
> 
> Well I haven't boot tested it on anything either, but it does
> seem to resolve the double quoting that caused the compile failure.

I applied it to kbuild.git#kbuild now.

Michal
