From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v6 7/8] uapi: export all headers under uapi directories
Date: Mon, 20 Feb 2017 10:32:12 +0100
Message-ID: <fc363060-f00d-e9e6-c548-6bfe73665e93@6wind.com>
References: <201702022242.toNVsxyq%fengguang.wu@intel.com>
 <1486724338-5389-1-git-send-email-nicolas.dichtel@6wind.com>
 <1486724338-5389-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170213074931.GA19927@infradead.org>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35224 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdBTJcQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2017 04:32:16 -0500
Received: by mail-wm0-f45.google.com with SMTP id v186so73036604wmd.0
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2017 01:32:15 -0800 (PST)
In-Reply-To: <20170213074931.GA19927@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org

Le 13/02/2017 à 08:49, Christoph Hellwig a écrit :
>> linux/genwqe/..install.cmd
>> linux/genwqe/.install
> 
> Third time:  NAK on exporting internal kbuild metadata.
> 
And for the third time: this is not related to this series. Those files are
there before my series and the goal of the series has nothing to do with that.

Feel free to send a patch.


Regards,
Nicolas
