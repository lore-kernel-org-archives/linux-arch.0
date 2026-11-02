Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661172;
	b=ggCkgbnrpbpEN130SKqgV1AMh/0d5zgGKE5sm8CQYG14RmcMI9MpVKuM9FVoRnKIcPj0
	 KKMmwJPxaVZ1jFYOBJXhcwLR3EHiGNx4DM+PbApDAW62N+g7TFojvdt7Crc63DxtePKm4
	 gsCWgEHYUnfsPoq5DMvv5zNxl9PMkdqGOMwsnZbOVMAz3KPnSpgLGqnVB2EcwOkV9hs90
	 M0jAtu4GIia3I+WuV8EG4cQA4h3oxjxvfhtwjUmZfb8EMK5fadbMrtlMblesCMAY/TFcB
	 iMQXCawGc/hvdpxp+KUPliqyfVWWIQfMnOEPNVfkkgfcpVDu0SLs5M+oWrUy629akZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
	b=1LpSK8BpLJWmnk7VMMgb86skx0+ZKoyeg9ZJuCBLlVAOKBMkIESrQzLGs6QwATg8TiNf
	 vx+q27uiueqY35LApU8Oijz4XXE4SiraDASgLzrJLbbQvv04GHHGXz6uhHxDBP+7q+kDY
	 ROoSI0iOMQDn44/LBzhjQfXLtmmhCEAyAkVdn1vvKmJYUnc5x7HnoGHvrVfNgtjMo3VvF
	 2y2MQ6dnG361YVxK6lBQrAOlbr8L5UK6+pLUO/6oYjotXkSswNt4p+SZupPS3ugCyLXo/
	 vOkaff/uvpGOdwOYgAJEUVJtBFCRVsf98bPf+JekZZyury2mguJ1Xa9yP90V02p+QGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="rx8b/Fy+";
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C2606A32C
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 23:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0C2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rx8b/Fy+
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b10ac6ab7bso30631307b3.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Nov 2026 15:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793661170; x=1794265970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
        b=rx8b/Fy+NjWKy9Kt9BkYBTAgAdfsrCjtSJw8M4hgKdPwSbdNWSPDWS+qzcv7PpS2X0
         5GpXVRoxUaZ06rvZROEMQEK8Mttmw9rGPzF93KOiP9W3KhIAYixd7e7GNOgC4Fr334R+
         ZMd7FukI1GTj1DTuhU9+GULRf5Xbb/LNWXhyf+MMw2FwhCJ82Zi4Ko0jgs9VZCKtAS5x
         oaNuyuW9O/UX3/pzgRC6JwSMVmrAnNCPfmYE8DdZzfw6boqxFs9vrYo7Ge/Mx04wtHt3
         oH7W5UO7A+o2/swON24J9mUTxAOGRp+JLyPEKuWH7Od/aF95WucAzIhYr4/n/eokeaGH
         ubDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661170; x=1794265970;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EamzdbmCJd/tsLqc1Uf5xYkgzwxHOHLxwnt7C9IRutQ=;
        b=qcVZwjl/+wKnU3qBw0bDmsiGNAT06KWJmKippGpwC7I7b8Myz7pzbY9TuJiY4pz3tx
         /rOauEiYdHeP+qP7T2n+0jOwUxnmwjNQoykGMxgI+sXY3OeIkfd01Kuq0cLS5m4avcnO
         oafz+8bKhr1Y+whDaOyo3/rfxjRHs0D4PHN2Bp6635cFa38/2fo4yFcOTjVDfezI8vxJ
         FlsG3vSsJObzGkqw96sPA9Oi5Xy+BxoWcu4kBev3MpZeSv/HhYOxCThuG7sxFQ+U8pqa
         IkhdlxOZsiu8QPs29eHlHWWlyYf3/jhUoKic/K/msrrbB87STFvs3C6cNwu4MOyEUvmV
         W83Q==
X-Forwarded-Encrypted: i=1; AKwUvBw5Cb+b/fq0rTqsTamJWmSJt/KRA60DJOEgohuLwS+6dtEsxRrkEO5sZ+dVti5Id1zasq7KFrPJ7BMq@vger.kernel.org
X-Gm-Message-State: APuU4Z+cNKIGM9fXTPjr7WEH4JiOUtIkkhl4SbRfVJdjBgEzOW5HOHrW
	E2/A4atAYE1+dQODX2EQSJbtwA3GQO54htc0P8BB13coYGDRg+3isyZ7+fOeJ4nq2VXq
X-Gm-Gg: AYBFou3dS1JTTjFXg9jIeebQBn7qSMaGHaXLroaAzIsGtDXlZLaRVFb3lVpVKw1Gq5s
	ruHzvPr6vcrOS75GnT14vHX6tEeHCOHGuo9Pv6hfVF/9wDvGSTBGZkAweQigqAYYyzWjW9c9uKV
	/OaoWwq6K5pMgzuoOwnKp9vets+2IvAuRqRL8feQYQl6o64swHK3By7s5BklMR8UUNZFDI93pld
	iN0hN8G56m9qR7wy2+A4hIk6u5T5zWhb7w/onEA5D8BW/99kjrJ5KIDT4nzP5QX8Jeck/yc3mJq
	otK9UzgEWuUm7fzvSVVY+ctilv+1BKzJ3TGMZN40JF3d97kCubpQuNBWPFlMFa4PaZFLJh1pmFH
	g6DXR8ZTX4K6zz07bZZBmnEmcwSiV13iGhTB7Oz52Dh9fDPII5ThUs02Uqqn8HxaBaqrpa837rG
	WPtd3qJBHKfdW+JVFVq4Vb+jSmIBGR+bypP4U2wXJEX0XY/2p1U+ln3/gOnuNO7KUqUBnQZNzTa
	OVqszyiA2zI5XOZTqKlS5/i8plvMLA9/mwNCx3e55ZCOy7evRALOT8JOMAPequjB5Ugh3jY7ogi
	hstSW0k67EXilJvMbio2liwUbaUOOUylUPMwU/0AnB4LeH14fgg1b3VBAd7w3/EE5VAB40hB7i4
	XpuD+Dea9y551LAPUrZ02ErE9BDfSYTY=
X-Received: by 2002:a05:690e:1094:10b0:66f:c1bc:408f with SMTP id 956f58d0204a3-67ba50187demr4711928d50.82.1793661169876;
        Mon, 02 Nov 2026 15:12:49 -0800 (PST)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3303ebsm5946481d50.18.2026.11.02.15.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:12:49 -0800 (PST)
From: Andrew Halaney <andrew@amutable.com>
Subject: [PATCH net-next 0/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
Date: Mon, 02 Nov 2026 17:12:33 -0600
Message-Id: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMAyA4VcZORtoC27DVxEPJc1sQKMkRSZj7
 76y43f4/w2cTdjhNmxg/BOXj3bEywBUsz4ZpXRDCmmMISas+ZWV/+j0RjIujq0a54JTnMI4h2W
 mK0HPv8aLrOf6DsoNldcGj30/AKCaSmZ0AAAA
X-Change-ID: 20261012-halaney-scm-creds-thread-7170680f8c5c
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>, 
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
 Andrew Halaney <andrew@amutable.com>
X-Mailer: b4 0.14.3

Currently, SCM_CREDENTIALS carries the pid of the thread-group leader,
despite carrying the uid/gid of the actual sending thread.
SO_PASSPIDFD_THREAD lets a receiver identify the sending thread, but
only through a pidfd. If you just want to know what the tid of the
sending thread is you have to do something like:

    1. Setup SO_PASSPIDFD_THREAD on the socket
    2. ioctl(thread_pidfd, PIDFD_GET_INFO) per message
    3. close(thread_pidfd) per message

For example systemd-journald wants to log the tid as "trusted field"
(aka provided by the kernel) but doesn't have a great way to do so
right now, unlike the options for uid/gid/pid which are covered by
SO_PASSCRED currently.

So add SO_PASSCRED_THREAD as a sibling of SO_PASSCRED. It delivers
SCM_CREDENTIALS_THREAD whose ucred carries the tid of the sending
thread instead of the thread-group leader. This is completely
independent of SO_PASSCRED, so a receiver can ask for both. Use
a new cmsg rather than changing SCM_CREDENTIALS because users
expect ucred.pid in that context to be the thread-group leader.

As with SO_PASSPIDFD_THREAD, recvmsg() on SOCK_STREAM sockets stops
merging data at a thread boundary once SO_PASSCRED_THREAD is set.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
Andrew Halaney (3):
      selftests/net: pass socket options to the scm_pidfd test flows
      net: add SO_PASSCRED_THREAD to get a thread-specific SCM_CREDENTIALS
      selftests/net: Add tests for SO_PASSCRED_THREAD

 arch/alpha/include/uapi/asm/socket.h            |   2 +
 arch/mips/include/uapi/asm/socket.h             |   2 +
 arch/parisc/include/uapi/asm/socket.h           |   2 +
 arch/sparc/include/uapi/asm/socket.h            |   2 +
 include/linux/socket.h                          |   1 +
 include/net/sock.h                              |   4 +-
 include/uapi/asm-generic/socket.h               |   2 +
 net/core/scm.c                                  |  32 ++--
 net/core/sock.c                                 |  14 ++
 net/unix/af_unix.c                              |   6 +-
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 229 ++++++++++++++++++++----
 11 files changed, 242 insertions(+), 54 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261012-halaney-scm-creds-thread-7170680f8c5c

Best regards,
-- 
Andrew Halaney <andrew@amutable.com>

