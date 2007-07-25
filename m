Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:59962 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbXGYGZv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 02:25:51 -0400
Message-ID: <46A6ECB7.7090208@goop.org>
Date: Tue, 24 Jul 2007 23:24:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <21803.1185331847@ocs10w.ocs.com.au> <46A6DB04.3000003@zytor.com>
In-Reply-To: <46A6DB04.3000003@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Keith Owens <kaos@ocs.com.au>, Trent Piepho <xyzzy@speakeasy.org>, Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

H. Peter Anvin wrote:
> INT 6 is #UD, so the __builtin_trap() replaces the ud2a as well as the loop.
>   

__builtin_trap() emits an actual ud2a; the effect is an int 6, of course.

> How far back was __builtin_trap() supported?

I think its relatively recent, but it might be within our supported
compiler window.

    J
