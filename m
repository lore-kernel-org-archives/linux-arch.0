From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 0/7] Use strict kernel types to fix the world
Date: Thu, 26 Feb 2009 01:24:12 +0100
Message-ID: <200902260124.13641.arnd@arndb.de>
References: <20090225235138.062045835@arndb.de> <49A5DC30.4080803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754201AbZBZAZV@vger.kernel.org>
In-Reply-To: <49A5DC30.4080803@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thursday 26 February 2009, H. Peter Anvin wrote:
> 
> > I split out netfilter, DRM and MTD, because of both
> > size and potentially controversial changes.
> 
> I take it this supercedes your previous monolithic patch?

Patch 1/7 supercedes my previous patch and is still as monolithic,
except for the separate 6/7 hunk. I only split the integer type
patches by subsystem, but I did these from scratch now.

Patch 7/7 is a new one, based on your input from the last time
we discussed it.

	Arnd <><
