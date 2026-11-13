Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528933;
	b=Jz0x7aArZq7H32V/TB6upxjuVMU7AuwfY7djNl3WCJlYZNYYTNpO1DK51w4z0T+rS/gZ
	 YZcLtenRWEmIOhIsVeJhHQoTaE6MUGxXWgfblYMwbUsgUGU49iplBhB1eNPXKL8rBNoFD
	 ce1KsodLuIf99MP0X+LdlWoIJL4EX3UqTF7MBkoXbEiAJ6vjwu2v6o3EXerIGir9CRaR4
	 d2jNKeK7PWOYCR716Ywzorl8z86Vrq7fC/xC8WOKhlefNFHsXYJj1OCENTtRV5Kw6Hm9t
	 GxftzyOHb+f3sERccYbayZx7WM8/2aTZhDanChE5boWDnTrYFlOJM8xBFcUYFsp33Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=61O++FJNcC4m027jbcMQkO8tdX8vxtYJyx2loV0XGJM=;
	b=LAhmVMX/uhyLTFzNnf+Qv0ZNq0ViCcW7xNMVBWDWj4y0E74qZs8GeOSngL/R0kzJ8iBI
	 vLnVxw26iQOFqV8xjSOzdVYOIfpt7ZrOv9p5/uaOGEI2Va4tk0q6ULDusqWdlA/9jdWKA
	 oeIPYfvGi8SuPDuyFCBrKCQIu16Rmk621GCV/GoRh1K6GKhy53CtjWxBi1BUu65dgR9Zm
	 DQyMo+CcEY28druF8Zy7PXIO/XvhHFVfJaqS+g6P6hgGrGxld3gv7D1nPQb9nKe+AvY2N
	 eyy/igFr4NieYkqmXH4kt7B2QDzyuzIzTwmuEBPALlAJKsOKqW9Rqe3UWuFA34nOarw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3gGVght;
	arc=none smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7960A261D
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 00:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC7960A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3gGVght
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c148d4dbfbso513381e87.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528932; x=1795133732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=61O++FJNcC4m027jbcMQkO8tdX8vxtYJyx2loV0XGJM=;
        b=P3gGVghtYNus1pwVAyzu75ZbePKoUj8l9ghrMz+6TXk00mR/PAfXnDhNBmSmHH1PKH
         EiIeXV65p9W0D7UA5mfmcHf7fs2phRv+t/Dl86n3Fq1UVzRDyiDPYjVN+3Sgzy+FTkjS
         GOMrlfikZsqhyo55AF/5g0BXluMlqY0GSbEQV549acI6H5tdfF/4la9ioLDz8BaCylLU
         wmRUBXEay5OJkUMosZWYyxoLSJHy0mzIAwFkUiz6uFlIZXg0HlRQPGPEjnNCmWgE1Nqn
         Ws+qiU1iY33gPJ+fYyfdf1aGa1kMwNoYlgWeFEcYoL5qCuHhPUYIf4hhRf8uDDZj23fu
         cSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528932; x=1795133732;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61O++FJNcC4m027jbcMQkO8tdX8vxtYJyx2loV0XGJM=;
        b=XO0EkWb5fEUpamYEj+ZGWLmBLpgUz5jsQEnOSLyaR5dK4q232DWKFIxkwiN50Rhz4+
         0EbhwIkYBCCrbeDmFUmD+rWYjNjGynzxM2Oj619CjBFJJrr7vX2M9PYa+G+/4zK2gl5d
         /80wemjSKZhDJdurItkeae7I59kZzYeFw8n1ALx/910OZGSlNZ5SyR8fTp8wkCEC83vc
         f6xXe5zj0NFjGMbbJdCdYTJCtkpj+YkP7D5iilisYl6S+enxy3uX5hUAIMF616OU3LAc
         Iwy87UDSOwvPktOYA+PJMy/bM8brjvtih7aWSZTLlvILgNh0HEBfWtj5oDkZKAiN0RQn
         D05A==
X-Forwarded-Encrypted: i=1; AL+hErFehUy5QMDEijw9DvsSCWbWafvobZ1I8nYiYvAPuGZUlG+1dbBDINsVs4n4OXmh3De8QGFt5sD/1h4y@vger.kernel.org
X-Gm-Message-State: APuU4Z+fj7/vagxK23tQ4AMz5S0CzYQvWEyZPhdImEffJFh1Ju95cD4D
	mjVg3TB1nZPsLa8j8ohjbiRcM+Jl4E7ghSmpKd7Qe+VquHr1zjGgXkXt/shRnG+heds=
X-Gm-Gg: AYBFou1nqcd/5707rZW4GIqevHnCcPvPqFBnJTe+Q3eqKpdvwAhk7FB6wXbdLrCra02
	2Qcl9ZEW+z90TOasXxC3w7+TsVlzLIa72qoUX4jIGb4xTLewR/1XDSCANhHiHd+TPJqM1VKsNWV
	uQMDva/FUk3TIsg/RlIixlaZVhIXBufFHWBej21odukbgHZ3+gsOeeomkiV51kESDASi3RC8VOF
	pIp1cfnIzDSudRkG+ISAZ1EIxkai6OoY+1KOkJVcZ/8l70AYIFxqypDyZvYILUQiDdy/WyjuJ/L
	rUaV+hULZ054JCFU6ngkT6LxsU4Iwqj3ySFknAy3sJZ+v/dnTVjcqe+udLJl/IrB1PUpUPj4cTE
	1w8+rBV3Kex1yYogzfcKeeooRdgiuaL4O29smx5m172uquIgG3LHm1xVrsd9Dj/vgxSkhdi0IXo
	5gioIbTDWOj0gd6gK5UBL2m5rgx3zjR8Ipf+EWCEMIiWNQMIT7Uky1FyKbuc+V2hUXCCKnuDK7O
	YZxiJ1ZrnvNOu0SxD6nDOFAbL6FWkYrXry5K82MFfcZq+xFkXWKT0L48gkGnirE4pchbs5vdLJf
	1ISxLLsAvRSdH2G5lektO819w9abjIwhP/fHssRWF0+yYTDcErbruoKx1H6dfsv5ZI09++C2q8S
	NYp1M40+4wuaRURlM91N+W/zIUF0kBEs=
X-Received: by 2002:a05:6512:12c3:b0:5c1:517d:fb91 with SMTP id 2adb3069b0e04-5c1705d83eamr373085e87.2.1794528931539;
        Thu, 12 Nov 2026 16:15:31 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133ca01sm200968e87.36.2026.11.12.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:15:31 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 09/10] sched/preempt: fix duplicate extern declarations
Date: Fri, 13 Nov 2026 04:14:15 +0400
Message-ID: <20261113001432.128201-10-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113001432.128201-1-safocl88@gmail.com>
References: <20261113001432.128201-1-safocl88@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a duplicate
echo ‘extern’ specifier error.
This occurs because the code contains , and
expands to  when processed by a C++ compiler.
The  specifier must be removed.
https://bugzilla.kernel.org/show_bug.cgi?id=222257

Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 include/asm-generic/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 1adddeab8..fc0da591d 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -93,8 +93,8 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_notrace(void);
+asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_notrace(void);
 
 #define __preempt_schedule() preempt_schedule()
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-- 
2.56.1

