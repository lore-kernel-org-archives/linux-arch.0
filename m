From: "hpanvin@gmail.com" <hpa@zytor.com>
Subject: Re: [PATCH 2/3] Adjust the comment on get_order() to describe the size==0 case
Date: Tue, 20 Dec 2011 08:09:57 -0800
Message-ID: <b52569fd-d175-48a7-a7e6-905821d89402@email.android.com>
References: <20111213145654.14362.39868.stgit@warthog.procyon.org.uk> <20111213145704.14362.62471.stgit@warthog.procyon.org.uk> <4EEF8652.5060201@zytor.com> <201112201509.21334.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55257 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab1LTQKL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Dec 2011 11:10:11 -0500
In-Reply-To: <201112201509.21334.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-arch@vger.kernel.org

Will do.

Arnd Bergmann <arnd@arndb.de> wrote:

>On Monday 19 December 2011, H. Peter Anvin wrote:
>> Hi Arnd,
>> 
>> Do you want to take the 2/3 and 3/3 patches in this series (since
>they
>> are asm-generic) or should I?
>> 
>
>I generally prefer asm-generic patches to go through the trees that are
>most interested in them (with my ack), which keeps the series close
>together
>and lets me not maintain a separate tree for asm-generic most of the
>time.
>
>Please put the entire series into -tip.
>
>Acked-by: Arnd Bergmann <arnd@arndb.de>

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
