Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55112 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbZKIEPp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 8 Nov 2009 23:15:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] ptrace: copy_process() should disable stepping
In-Reply-To: Oleg Nesterov's message of  Saturday, 7 November 2009 22:55:47 +0100 <20091107215547.GA25335@redhat.com>
References: <20091106211637.GA1696@redhat.com>
	<20091106212554.BD731CF@magilla.sf.frob.com>
	<20091106215004.GA2232@redhat.com>
	<20091106221002.8057DCF@magilla.sf.frob.com>
	<20091107215547.GA25335@redhat.com>
Message-ID: <20091109041546.925461E@magilla.sf.frob.com>
Date: Sun,  8 Nov 2009 20:15:46 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20091109041546.JWuUYKQcZua5o8hNH5I75Z8VL2w5AKa36Jvj769r6mk@z>

That is inappropriate use of arch details in generic code.  It might
happen to be harmless fritter in practice on the arch's we have but it
is certainly not the correct way to go about things.  You should just
call user_disable_single_step() unconditionally.  Even on an arch with
no such machinery at all that should be defined safely as a no-op (see
linux/ptrace.h).  If there is some reason not to do that, please
explain it.


Thanks,
Roland
