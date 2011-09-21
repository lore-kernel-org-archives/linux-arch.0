From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 40/57] dirvers/parisc: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 14:07:04 +0400
Message-ID: <1316599624.2966.12.camel@dabdike>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	 <1316597339-29861-41-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316597339-29861-41-git-send-email-yong.zhang0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Firstly, we don't need 57 patches doing this ... a single one through
the trivial tree should be sufficient (and it can nuke the flag at the
same time).

On Wed, 2011-09-21 at 17:28 +0800, Yong Zhang wrote:
> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],

um, that's commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922

James
