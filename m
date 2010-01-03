Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:39680 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752900Ab0ACQ5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Jan 2010 11:57:09 -0500
Date: Sun, 3 Jan 2010 17:30:52 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/2] resource: align functions now return start of
 resource
Message-ID: <20100103163052.GA5282@comet.dominikbrodowski.net>
References: <20100101163811.GA8124@comet.dominikbrodowski.net>
 <1262364050-8540-1-git-send-email-linux@dominikbrodowski.net>
 <86802c441001011412u1543c1afk6337cd6d3ea0f257@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86802c441001011412u1543c1afk6337cd6d3ea0f257@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Message-ID: <20100103163052.jpSEXyFVsPbdHkdSxH6KFEoZjHj7AV93gAAeJwm4zDo@z>

Hey,

On Fri, Jan 01, 2010 at 02:12:09PM -0800, Yinghai Lu wrote:
> > -                       res->start = start;
> > -               }
> > -       }
> > +       if ((res->flags & IORESOURCE_IO) && (start & 0x300))
> > +               start = (start + 0x3ff) & ~0x3ff;
> > +
> > +       return start
> 
> missed ; here?

Indeed -- thanks for the hint.

Best,
	Dominik
