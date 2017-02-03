From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v5 5/8] Makefile.headersinst: remove destination-y option
Date: Fri, 03 Feb 2017 22:45:22 +0100
Message-ID: <1486158322.16569.3.camel@tiscali.nl>
References: <20170131162133.GA8258@gmail.com>
         <1486041910-2665-1-git-send-email-nicolas.dichtel@6wind.com>
         <1486041910-2665-6-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1486041910-2665-6-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de
Cc: mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

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
