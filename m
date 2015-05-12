From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 00/21] Re-introduce h8300 architecture
Date: Tue, 12 May 2015 09:29:54 +0200
Message-ID: <9302360.f2Sv7QXQxG@wuerfel>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp> <16018199.XO2Ye1J7R2@wuerfel> <87sib2pbsu.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sib2pbsu.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 12 May 2015 15:09:05 Yoshinori Sato wrote:
> > It would be better to do one of two things:
> > 
> > a) use the code from lib/checksum.c that is known to work well, and that
> >    contains all the necessary exports. It seems that the h8300 is
> >    almost an except copy of the generic code, it just misses a few
> >    improvements that were done already in the kernel.
> > 
> > b) provide an optimized implementation written in assembly where necessary.
> >    This can provide a significant performance improvement for TCP/IP
> >    networking.
> 
> I think option a.
> It was being written by an assembler before, so that was just left.

Ok, sounds good. You can always change this to b) later if you run into
networking performance bottlenecks in the kernel.

	Arnd
