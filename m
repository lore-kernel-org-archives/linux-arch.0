Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDB315D3E
	for <linux-arch@vger.kernel.org>; Wed,  4 Mar 2026 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632338; cv=none; b=Eyys5AeTSze7bbD2zOSiQcvncpHArlBvir1PCte31pVY+Izq2BO4URyD9DA9aGJW88mi3ap0oq0z36WDz5vjpilZ3Bc5yT3M73XxJJ/gkFJ8cS/TDAu3k4irg1NN6d/YggL4sEkj+ubihzEuZR/ys2nYPVlmw43Rckm4i9Y1NC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632338; c=relaxed/simple;
	bh=Qd0rnZBE1xws3W96Pw5Blesuqote85Z9+msEuuIV0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQgHIR+EA+GS2NqVdcyw1XNx9BD9eSGkgsJ9y8CXXFRWfLFD8kpuqlW8PKZlzsioolu0JePLfOdKs4Dmv1euStbn6tujnvO4Gvo3/iQDFK3Znjzq7g2Fq1T3CYLjckSQ7BZ8mJZk0w/qgzNTqq2Rlwr0f6Jx8eP2hPs3rBSo9b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTn6+YFa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTn6+YFa"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8272a56b91cso5764004b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Mar 2026 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772632336; x=1773237136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2OLS1A4Uw6yTtRylm2HkzI1Tav6toxZGMwlbuYQ/RI=;
        b=TTn6+YFa3yAte04xVzej6i18jmH3Oul6pfdYfoWepIyCDAcUYv9GIyNYmt4WJKDxrU
         irRNLZ2lWp56kopNbMTvwktTf7rY2E6aBRuGbFvmcfPrA4NQ3XorqfrXoHkxthUvReIS
         YY62x2XOQFKmZdyarGJyF7kea9rDjMjPqUfOS5H98Tuk1I281k9v7ohn7UcEURqu0iRI
         fuay2S2KHXN84aRieS7LbltIBmmF6vdUp9w0aO1lUzU2BsViHPSj2MPhwhjIHroaf2Ll
         B6PSK5zswssattKTDaDlEPVCkG+BDm9n7G42wCqM5yiWzZ/NztnsdshSa/pFiillnrcr
         UyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632336; x=1773237136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2OLS1A4Uw6yTtRylm2HkzI1Tav6toxZGMwlbuYQ/RI=;
        b=PWPz3yNRPEQ/I7n/ZRTiLVRyMpJ3hRmElwvSj8E3s6Y70RDGZ5bAchPjKWKLtUPrCi
         vmvbkWKxZPML56Re9ppYSplyYo7N8DmLTZyhmh1cKQba5WH4+LU7V5WNCOehhX9Nqd+h
         Mqt4w/C405MhUXx5ipHO21r5RSFnlV1BD7bO2enm1nfqKaGyZ1UnOQSZw2UhgBsDORkY
         vjuaGaV6eOvg224vIXzRz0ACKMyh61JKsXJMYUPbtHnPiTnymnsBgRFdQi062JpAMczp
         N+pv2CwG7Ahgb7FaVyZPtB5emd9YuyJK08s21phkAnQQSQRi3Iy8qyz3T4oqebDYbVWk
         kg0g==
X-Forwarded-Encrypted: i=1; AJvYcCVLt3U5Vh4CJy5tEaBUdzGHMVP2GMyNE0e6EJDWWRrYm4ldQlroJsd71349Qp77dWyy1sBvq/yJ4q1C@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh/lXi9fwTOQrCKNJICsY1Gw9td0O1WwsUYJ2jJtH7y4xvaFJj
	JmZdqMyl0bRlwcwrsygUEzy5mXnfRufG0OyASSXqmYiZccjHY9ngyFLu
X-Gm-Gg: ATEYQzxwnKyioFfAiYkHUNlW/84vQ1j4F4ez01Rug4xL7ZpyZm0gawsXx1O/p3sGgvh
	hfDq36/72yx0UofG5uFm4cqUdtvBEDEAy0cqxZiYjYhJzsUaOqy27okantkhSIVEKrBjoyoZtw3
	yc2dBVrfz16ZCPADuzSQo1rBx71nhnOFAUvccXdd9h6HGvjrND50424pNfwmnRQ5HkWgARdrR+J
	Aq3+86zhA/wFqaecBnikJjhP5E2vamntENNS+SQlJStk6nbcxJBWUKNhIA2vPvTgOkPB0N1ujcF
	E5F6N0NddlaXXD9ECaIBZaIZEDR1Gj6XSGP4sOh5MC9quFs8nWLpuIn0yoc7c4VJxCDN3feyatm
	k3nvfpOxXTLoD2pfgyu/403vZIA4/G1RaymH2kSF/3fTfySzh3tlFqPOkX0oZpHCXDHPkQp6E8X
	LukkHT1R8vwPJP9zW7RE4RGQ21VW5urAOK4g==
X-Received: by 2002:a17:903:19ee:b0:2ae:4222:4535 with SMTP id d9443c01a7336-2ae6a9ed187mr19145415ad.12.1772632336110;
        Wed, 04 Mar 2026 05:52:16 -0800 (PST)
Received: from Modern-15.. ([2401:4900:86f4:d8e0:8d8d:c166:cad9:b4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm199264225ad.70.2026.03.04.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:52:15 -0800 (PST)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] [PATCH-V2] mqueue: introduce new do_mq_timedreceive2() [ mq_peek syscall] for non-destructive       receive and inspection
Date: Wed,  4 Mar 2026 19:21:22 +0530
Message-ID: <20260304135126.77270-2-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304135126.77270-1-academic1mathura@gmail.com>
References: <20260304135126.77270-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following Two warning issue by build and test on V1:

1) include/linux/syscalls.h:750:42: warning: declaration of 'struct mq_timedreceive2_args'
   will not be visible outside of this function [-Wvisibility]
fix-included the missing header for global visibility

2)  warning: syscall mq_timedreceive2_time64 not implemented [-W#warnings]

fix- This seem false postive warning, script not able to correctly map syscall table
 with handler
in file - ~/linux/arch/x86/entry/syscalls/syscall_32.tbl
473 causing warning due to now explicit handler for name "mq_timedrecive2_time64",because
it also handle by same normal SYS_DEFINE for  64 bit arch  because logically both are
same if 32bit machine call 64 bit, if we add named defined then it create unnessary
 redudancy and duplicacy, so even at this time i am not changing this, if required kindlly
once test in runtime and guide me.

472	i386	mq_timedreceive2	sys_mq_timedreceive2_time32
473	i386	mq_timedreceive2_time64	sys_mq_timedreceive2

Reported-by: kernel test robot <lkp@intel.com>
 Closes: https://lore.kernel.org/oe-kbuild-all/202602270443.k6N6t2u4-lkp@intel.com

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 include/linux/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 4db405159a8b..307cfd6f154c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -93,6 +93,7 @@ struct file_attr;
 #include <linux/key.h>
 #include <linux/personality.h>
 #include <trace/syscall.h>
+#include <linux/mqueue.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 /*
-- 
2.43.0

