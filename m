Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from lb3-smtp-cloud6.xs4all.net ([194.109.24.31]:56558 "EHLO
        lb3-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752439AbdBCVpd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2017 16:45:33 -0500
Message-ID: <1486158322.16569.3.camel@tiscali.nl>
Subject: Re: [PATCH v5 5/8] Makefile.headersinst: remove destination-y option
From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 03 Feb 2017 22:45:22 +0100
In-Reply-To: <1486041910-2665-6-git-send-email-nicolas.dichtel@6wind.com>
References: <20170131162133.GA8258@gmail.com>
         <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
         <1486041910-2665-6-git-send-email-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org
Message-ID: <20170203214522._WP3gIzGtBvzyzEEPmYjSuPuoH5G1ABmugKvXjPI74I@z>

On Thu, 2017-02-02 at 14:25 +0100, Nicolas Dichtel wrote:
> This option was added in commit c7bb349e7c25 ("kbuild: introduce destination-y
> for exported headers") but never used in-tree.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

I've got an identical patch in my ever growing stack of stuff that I should
actually submit:

Acked-by: Paul Bolle <pebolle@tiscali.nl>

Thanks,


Paul Bolle
