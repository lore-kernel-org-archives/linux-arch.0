Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8628431B10B
	for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597444; cv=none; b=az7E4+oeilO39/NOZLMbt87R7OGUiAekBIV2b/G0AR21oJb++JGFMmvG7wQYqUc2yyF652bMhzHbdv9xUlbfuAkwD1zwqk2pWB3HHBFw2scDZRxSFFF3t0e4AfGs+oMhgHRop8P+mhc9c32vMRHL+uORd1wiT4W7FAPf+wS/w0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597444; c=relaxed/simple;
	bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yi8nbZo6X48WrpiDzWQUe7YbfVzndDQ18+8/0DkxDASsMjZc99leBYi3LF/H5KUqd6N+7Kdc2qAoXFvfalWZZPPlBfCmWJWM8ImKmfn3rB9IuObibo7TZZuYJCad+KFIlGxhMKP7ZOsfUGxRNBCqjridyYeRhIZg19IkdSZtMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifx5WQdb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifx5WQdb"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-367c2a39fcfso1935129a91.3
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597442; x=1779202242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
        b=ifx5WQdbMJ1EKUB1nvHQg2scL/6w9HnFph68opML5kty7ZwlJSN/ZTC3yvEGuVl/Ma
         pXm9w0vpU2DdWi57Q4A48m0irbM2xKAQoaEK22o118XxSlC8u5PhqOsjbnbe7m/K5vvm
         69/IHNv/R3KS/x+/YbYv67fedIDolur3At5FLX2JnBrUcO2sLGJvNDXJdIenaM84BIId
         lCMSz1LGP1TO1qtp5SmzIhYLwbat40a/tv8oApVFldc5mYrEYgh4DTs7FNUUMe8HEsh5
         cGcGmIUU7tPve9g02Ut0KZtDY2z8LInC21xBvQ0aLeH51jNS7DehaOJJoTI70OckwQyl
         fsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597442; x=1779202242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zIk76PWOcKB2l3yZdOPVMHe0lxkjQ0sieXJNUO91W+U=;
        b=Sl5CaTDOaTy5q1RPlDa0A6TRr/eaWE41EXK7TP/wZ7Xas0YQ+RhMLvAPn9fTGIMJ0S
         LMiVbogJFQSGhphat+6RqNSE5J66mJmsUXGqWa1A0vuoAJbN3aAitnP68JcGNn59xsil
         ghnFLm0NSypJwsdmiUDnZ7NJ2416txPdtmOl8M0vFtVnU9qI6kvcEY/8Dy2aog/8otBz
         HkfRyM/A4LW1WvIJKPkmWH8t/OPUiF30GOBvzR+a4ZCPnkykx0qa5QAlmuY/Jo4VYxLa
         KBEzJufauKbzQUvsJXsbddrtLE3DEFL4ZjgBIvRjM/QO3SCJO9vY0ZmdMpEY4pFuHMNG
         IU7w==
X-Forwarded-Encrypted: i=1; AFNElJ+Ln0HZV47Z7w0f5m2HbxcoAoilPi6RyI+tzfqbXsdoyPKMoP1sw82DlCCDTiUfUNbJh/601V3mq8YJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bBiBi0nsnAro9BRBTIbj69iEGb8ubEiPHVc3As1ZQCn+MEod
	KXOOCGMPvKboIddFpqk5GPg7bz9wgXPuQJ/DGgE8UpsGHXIf1nG3ij0K
X-Gm-Gg: Acq92OFVAWHTPANP9ZFUBdglJGXaRUWdXY6DBAhphQKtZXHm+hEuSQcf1jbzZu/adrv
	ubzb0QL3OFXKYi+oWsxUp7poNVw8qPxGBG2ZQMHHJcoAuqmQ92nttGK0rLE2JsbO6j1j4bIflhM
	puRELM9S13DCcRQj1OHPgG/0Hzs78cuP7myyUmdo0mnJtt4oLnx7zBlIg/uO1jshLt8s2eHRzk4
	PDm4TgrOf1rksKlZkYa/RUaXB4Y/oyQ5wqCVnVYvIEfuudNeIHfq8s0GwqDX7Z3i5w7+b2Dxcv6
	TmRxLJuMa+fJ7FetPQv8cWYJdJCXiQu7s7hhl8MRVWOK39at6sUMzSxr8+P4VWV6ZBX8Cy8mTgq
	tSpXwtWHdXwQ8sKGIRvridRERpXtjnr+srUOIs0GdByjTLFoNCYuUpbstUfU5M9VVDHY6vBmDgR
	kKrwfbafwP7CAk8CnQQ29nY/Df0205+a3dji+k59pc8bLgA9D9
X-Received: by 2002:a17:903:1aae:b0:2b0:60db:7927 with SMTP id d9443c01a7336-2ba795bdee7mr304729035ad.28.1778597441578;
        Tue, 12 May 2026 07:50:41 -0700 (PDT)
Received: from honglab.tailc96cb.ts.net ([140.123.97.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ba2sm146193705ad.50.2026.05.12.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:50:41 -0700 (PDT)
From: "WEI-HONG, YE" <1234567weewee457@gmail.com>
To: fedorov.nikita@h-partners.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Subject: Re: [RFC PATCH v3 3/7] hq-spinlock: add contention detection
Date: Tue, 12 May 2026 14:49:08 +0000
Message-ID: <20260512144908.610907-1-1234567weewee457@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260415164459.2904963-4-fedorov.nikita@h-partners.com>
References: <20260415164459.2904963-4-fedorov.nikita@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I may be missing something, but this patch adds
`update_counters_qspinlock()` for remote handoff accounting.

I tried commenting it out locally, and the kernel still built successfully
with `CONFIG_HQSPINLOCKS=y` and `CONFIG_HQSPINLOCKS_DEBUG=y`. I also could
not find a call site for it in the series, so it looks like this helper may
currently be unreferenced.

Is it still needed, or was the call site possibly missed in this RFC version?

Cheers,
Hong
