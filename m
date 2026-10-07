Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE01331ECB
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791340157; cv=none; b=CyCOhhDKau5aUj8wsZnhrNqvMAHL7BKEFMPnDk1g1gB8NiDgoF9Vrw5Baimu6mYjSTdcrjxst/rokBz81pVoViHmrWUl3JsQ/UbR9mkmpM53Vw1KX8Sza7S1aK0E15WCHMduQriU571dxViCByrTF0kFkAUm7iObg/O4i1KAnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791340157; c=relaxed/simple;
	bh=bIg4WCGXbdDY5+O81zvgzW0QdrMJj+TZqAw5xTla9jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xfb04m+b6UgXIN2yWug5LVY0s7vFI8q2MQaORokDz7dxp7jN++Wf7RYdFUnx+pb3zOttx5Bgg33vdE2Qs7wItSxzMdJAL9jqYRuv5hdAhLvygldYXQeVp6Kce3KJbcfUhs0UXqCqyMMXq8XSC3NQbwOY2iU2otB0BWfRn11xcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doNjfxGO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doNjfxGO"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc50ad2d650so792548a12.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2026 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791340155; x=1791944955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKTyjSqWs6SfFGkHuFH/1TC7Rr/MxEn7bGnFGnrhrHs=;
        b=doNjfxGOwlQE517G75MQHFyGZlNi+NkhdZRwnMZgNmm6Wxo7JlSRCIKwjjLi/3l0La
         za9QIO0DOoEvYH/TLK7wHEKez2hxWq89PfDlwsrWMmC1Mibl1bXcRovr2M+35yDP4Vb7
         sBwXSBFAgrud7mj9TxKHWlV0n9D+5Q+o1rZXh7mN3pnHCVCZAbZzECZKPVXZgoiUt2hG
         yl1QIr1OXCANtagsi3/jzqQspwV2o4/hf44wE8qd692CkxH0qlyhxXQORJpsDaXsAdNZ
         WiEVTnx2LqcbmK+wQVbE9sW16iUwu3Khpdz+Muf6R2rBhO6w/pcxWaK1uonih78pP43G
         iLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791340155; x=1791944955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bKTyjSqWs6SfFGkHuFH/1TC7Rr/MxEn7bGnFGnrhrHs=;
        b=yoxXjikZgUeEv24esQSH+YpKGnernPL3M+H413TOlfDxC57oifpLUEWTge+30wy3J6
         nhjUhARJEY+GYoYmKaYqetGksGmJXVxuF6rkUnlTvldzIbrFMBKoxkHxjlXlaoOUHrh4
         VSzpciGVg69f3KnN8p6u22h2BLyF7L9ECyFmv/P26p8s/RrHL1LsDitHpG+mJcR6vpBs
         16CmLUvDZ6d9pysSAeQmpKMX10l66GzM4QGbYuCDhDVJFbkA143AM0cYPb4k3YHn8YiN
         qiSUe2WlFa+lu3RM40au0e9UzJKUAfcsxIm5JnI0xobCMgi3Xu+9R2c3SboyvRsXPQ6u
         eURA==
X-Gm-Message-State: AFq9FYI0VZaSyP2wU7XS+MC0rT/3O07vOIPUN6gQaQXEpRfnMnACVNAj
	8Asw2KDHhYwkj5B9wXZ7DLdhY93utoYyZBNV1tqYkpeb+DzHhakfyoiv
X-Gm-Gg: AYBFou3bKo64SKocwvk3qfMmuilIsJUVeqXFK1zhV4NUhSM60jdYWdOHbUgnO/zy8mR
	mgbKYGDduOhjft8gH9z8MyysH5cspB5RKRWAOUFz7NW72aBJL+FqFIFMfTo1xJRuI84SH5N5i3+
	00E0v3yImD5RjKOMMdSCGJa+pawE30FJvx1HeiNK2szYXg51hU8j0XB+0aCPWY+ycO5XrEyQiXd
	xTls6Z+Wp7kvrAm7o4ExjMSocXsjf0Lhq5ZP+pxWE3Kj2rmdgZ1t68U05Ck1QdRar9YCRqKSWhi
	wRbZZaonq6vXmlynWrdGYgwLAWxnLxp1jXvsQlLO3LwVdY6gx7ALC87qQ6LQETRmMhlaL9RmUHX
	Xp1LoU6RVgMk8MYVoh8S2Bk9vgSeyrfMNWBRrQQwuE6Fv3ysdq7L5fdgWW+zdxEYk/MQXW2juvK
	PBoc//9U4setROpxALotyV2OwPEWQkLaHX8oKCuc4YsSiGJ65k1xX4xE/gjcZ2RaBj0dgG3rMT1
	edMRftbBvUB6+KtAdWYo7aTtRolhg==
X-Received: by 2002:a17:90b:134c:b0:39e:6c6a:657d with SMTP id 98e67ed59e1d1-3a8a14f173fmr684672a91.64.1791340154609;
        Tue, 06 Oct 2026 19:29:14 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89b5c5d9asm2090836a91.11.2026.10.06.19.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 19:29:14 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: arnd@arndb.de,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v3 0/2] rwonce: Introduce {READ,WRITE}_ONCE_THIS_CPU()
Date: Wed,  7 Oct 2026 10:28:57 +0800
Message-ID: <20261007022859.60101-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a rebase of v2 onto v7.3-rc6 with review tags collected
since v2.

Changes since v2 [1]:
 - Rebased onto v7.3-rc6.
 - Collected Reviewed-by and Acked-by tags.

[1] https://lore.kernel.org/lkml/20261002151757.3605081-1-kunwu.chan@gmail.com/

Changes since v1 [2]:
 - Introduce {READ,WRITE}_ONCE_THIS_CPU() instead of reusing the
   plain variants. (Thomas Gleixner)

 - Expand the commit messages to state the KCSAN rationale. (Thomas
   Gleixner)

[2] https://lore.kernel.org/all/20260920085434.2918331-1-kunwu.chan@gmail.com/
 
Kunwu Chan (2):
  rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
  timers/nohz: Mark got_idle_tick accesses as same-CPU races

 include/asm-generic/rwonce.h | 11 +++++++++++
 kernel/time/tick-sched.c     |  6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0

