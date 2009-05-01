From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 15:20:33 +0200
Message-ID: <200905011520.34097.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905011453.32006.arnd@arndb.de> <20090501141414.4adfe4ab@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760358AbZEANUv@vger.kernel.org>
In-Reply-To: <20090501141414.4adfe4ab@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 01 May 2009, Alan Cox wrote:
> Currently if you create a new architecture you have to figure out what
> your equivalent tick rate is or you get an error for not defining it.
> Ditto if you try to build code using it on platforms that it is
> meaningless (eg S/390) you get an error.
> 
> You'd lose that rather useful property.

In that case, I still think it would be good to have it in asm-generic.
Half the architectures define it in this way currently, and new architectures
would still have to think about it before falling back on the default.

	Arnd <><
