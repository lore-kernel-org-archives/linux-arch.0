Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:47969 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754721AbXGYRBZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 13:01:25 -0400
Message-ID: <46A781A4.40103@goop.org>
Date: Wed, 25 Jul 2007 10:00:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com> <46A6ECB7.7090208@goop.org> <20070724.232914.56812376.davem@davemloft.net> <alpine.LFD.0.999.0707250954400.3607@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707250954400.3607@woody.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:
> .. and I'm pretty sure it's immaterial.
>
> We don't just do the "ud2" instruction - we also do the file and line 
> number information after it. Which means that __builtin_trap() is useless.
>   

No, not any more.  The file and line info is out of line, in a separate
section, indexed by the ud2a's eip.  The main problem with
__builtin_trap is that there's no certain way to get the actual ud2a eip
(ie, paste an asm label onto it).

    J
