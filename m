Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB353B6344
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477124; cv=none; b=ny/rcgkbKrA3eWjlWJYJOTqvTHca9KXf/8/IfxVwPf7iyVRJQYuostYfUBn/YwFwhhxMF8erxCncfz6ABl1lhvxeWpiB+xfb5REnTPE4KT05FVI1z5bXu7Br4K7EvFf2Hq0R7Js/lkLz3D5J3SDEaKx9KmlRnyWfXKzktsu7UzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477124; c=relaxed/simple;
	bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cm19v8Aa3opxI+pzCnW05ytW7lYnYgFX0SH2DhTSXay73uxOtoM7EV6pdArB5KpBKJbcdxWOnpzASxm72UZ6n0vPTkBhj37bvyCoHx19YtevTEA9B9bPpGFwJfZCu0XOq/42CvMsqkAnnK+Oqdcckie7BFZQT+vF5hqCIhRKD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVmUZcQL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVmUZcQL"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-491f5e6d564so114209b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477119; x=1784081919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=rVmUZcQLaFw0aNmApg6noNV43uIbiXNhcrYwmKT2v5ATs44QHqEXN2gl9qBnhTIoKM
         y11v8/9pWYpjo697LEUyIKhWdQ8CC5KWEpLBJaobQ4xIoUKsk1u9fKCdHgyMzTqhUVGE
         KCS5iPtB99xFqDak++QSBP8Y82qWcXOYRW+sMWHQj7H59jiMrnnBeRCYdAkQ2mAej+8G
         k5+rdPsptizeYQZAtHA7PTIQfZqJlf9v4grm+IaUFGHO7ifm0ggyccetlw/oWW5x3S/F
         xRYCwmJvl5HWyJlcW+y3pxDyM8IZYzTUnUOlbzcF2ADBEuxcyoVlvkEv0ZROmqcOkFAO
         NJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477119; x=1784081919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tkpd6XZrbayv1qGlRLm5NJZ/GcnFTR7uIhPPki4vU/s=;
        b=GU1shn9GxO4HsEpVxhCmQsFesedwRGed8OawWxi/uKNk4OJxiEg033bu4OZpM8daBP
         qE6VueUqP0MWHLFeI9aH6v1VaehOTNge/2zKd+mXtoGCiqur+12J4/aaG+w3pL4mNG3u
         Oc1MLqzZnDJaDLLDxUrBezSQsCSkv1lvfb1zxnDcLCuRv1Dpd7DC/yffr4NsxxYg7rMD
         cPYH7wRPZowFHDCQjkm7I+wu6aybOy0YFCCUNQWxZqGXQXz7BdFhTPyboRPAl7XYCvVH
         /rXoy/I73nrf3D8lPiX/Y1JXwj7qfA/Z7h7vBMpPlT7473MWe1gnlq91dd4q4ExK3gLZ
         uRrg==
X-Forwarded-Encrypted: i=1; AFNElJ8ULmNB0fIrYDfuCvO+9ucr2txb4BIuccIymEDwmqhQAFlDqu5x0onvnBnnhpOzBLisF7iKjm2AMaMX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vNdYO8is8B8Ey4/L0c1+AW4YnOZ6q98uoghHAIhAqEu3zGHj
	ww083Mm4VewS0arEMkaE66zaaVScpXUoX0gPC4fZ7LS3hYNAgVNXgE40
X-Gm-Gg: AfdE7ckTV0tF51DVkWnOSgmq93DJKxnguzAAKfWHBHoiYBP4Go+yKb9GEDTx8D4f9lf
	zAJ9uAgcYwC+PFzdXH2VX+phl9B7sGqVJLnkeoIKPD+4joi4f8gAMB4mRqjg6SEUudl3XD9DF+f
	YEzlFTRNWVly00jiWa354Epo7sWDQjw3DZ3GeV8xaRBc74fuReVholP8ZGQTVhPEd9rV8RRc0Rq
	si14hHYGrrGAPQ0OQ80FLteYB1BCx637aLPIGfc3slwb1XznIn2h+FGLDAjnmUY9QMWNCrEu9uC
	sONOHOq6YQGpAIxL3+4GHU+Ib0oA5Vs85hGyJDtwnnzxoI/bVpZVgCscyEPoKmaaM3tAyWy5wn3
	R72Lktt28UdGTEsGhFvCXh5UXvR31j7u0mHWCDE/Oq/O8ebtl7RFzPaUN/WiqpJq4BSSAtIVDCI
	4OFTe9WD6SA7CHb5mWeM3aPXbsbKM3wmAm9FxoBBu57/9lFCoEyq8=
X-Received: by 2002:a05:6808:1385:b0:496:301:36b9 with SMTP id 5614622812f47-4a1fea2d9fdmr467296b6e.0.1783477119240;
        Tue, 07 Jul 2026 19:18:39 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:08 -0600
Subject: [PATCH v6 08/24] dyndbg: reword "class unknown," to
 "class:_UNKNOWN_"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-8-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=1375;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=yfxjNCD2FfV6WQ7UCS9hJEIU3/cj9TtYhccgD7F2GOk=;
 b=BqO4fRVBObl9QNOP0WewNHKxLyFZjbRWwWNClrxuHOAw7XsQmdRiZGqV/r7Wn3OiYiYYQsKGT
 PfAkGsNm/bUARzjCeCDIMDx56NqFAFY351zybs4JuMgykY0D7McoJD5
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown, _id:N"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_ _id:N" to loudly announce the erroneous situation,
and to make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.55.0

