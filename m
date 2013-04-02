From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks, v2
Date: Tue, 2 Apr 2013 17:56:07 +0200
Message-ID: <CAKMK7uF63ttYwN-D+ZrivCw6m1hw2Qgf+3ut_iCsMkgEbL5LPw@mail.gmail.com>
References: <20130228102452.15191.22673.stgit@patser>
	<20130228102502.15191.14146.stgit@patser>
	<1364900432.18374.24.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46079 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932598Ab3DBP4I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2013 11:56:08 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so586188ieb.34
        for <linux-arch@vger.kernel.org>; Tue, 02 Apr 2013 08:56:07 -0700 (PDT)
In-Reply-To: <1364900432.18374.24.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org

On Tue, Apr 2, 2013 at 1:00 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> Also, is there anything in CS literature that comes close to this? I'd
> think the DBMS people would have something similar with their
> transactional systems. What do they call it?

I've looked around a bit and in dbms row-locking land this seems to be
called the wound-wait deadlock avoidance algorithm. It's the same
approach where if you encounter an older ticket (there called
transaction timestamp) you drop all locked rows and retry (or abort)
the transaction. If you encounter a newer ticket when trying to grab a
lock simply do a blocking wait. So ticket/reservation in Maartens
patches is the analog of timestamp/transaction.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
