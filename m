From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/2] asm-generic: adapt delay.h to common implementation
Date: Sat, 02 Jul 2011 19:11:15 +0200
Message-ID: <1309626675.24186.1268.camel@localhost>
References: <1309600754-21217-1-git-send-email-jonas@southpole.se>
	 <201107021321.10786.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107021321.10786.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hans-christian.egtvedt@atmel.com, lethal@linux-sh.org
List-Id: linux-arch.vger.kernel.org


On Sat, 2011-07-02 at 13:21 +0200, Arnd Bergmann wrote:
> Very nice. Do you want to keep that in your own tree for your convenience,
> and merge it along with your architecture, or do you prefer me to
> take them into the asm-generic tree?

I can hang on to them for now.  If the architecture isn't ready for 3.1,
we can move them to your tree then.

> 
> If you want to add them to your tree, please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Done.  Thanks,
Jonas
