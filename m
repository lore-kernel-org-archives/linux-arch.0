From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 1/4] [-next] Makefile: Do not call cc-option before including the arch's Makefile
Date: Sat, 26 May 2012 12:41:35 +0200
Message-ID: <a62d9c3d-9792-443a-aab1-4e2af6604dbd@email.android.com>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org> <20120520092744.GA21341@merkur.ravnborg.org> <4FBF7B34.2080506@suse.cz> <4FBFEC74.7090602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33823 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab2EZKly (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 May 2012 06:41:54 -0400
In-Reply-To: <4FBFEC74.7090602@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-kbuild@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:

>On 05/25/2012 05:29 AM, Michal Marek wrote:
>>>
>>> Michal - was this serie ever applied to kbuild?
>> 
>> The first patch has to go to the tip tree, where the
>CONFIG_READABLE_ASM
>> option is introduced. The remaining patches can go to the individual
>> arch trees, I see Geert already pushed the m68k one.
>> 
>
>OK, can you ack it, please?
>
>	-hpa

Acked-by: Michal Marek <mmarek@suse.cz>
-- 
Sent from my phone. Please excuse my brevity.
