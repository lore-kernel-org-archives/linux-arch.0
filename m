Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D21E1A3B
	for <linux-arch@vger.kernel.org>; Mon,  9 Feb 2026 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609043; cv=none; b=tnmZOzU/Z9z7TkskygC+buptsXyCWQKNgtlyTgZuO7ttGuZfhJvHcSkwWYgatCiE+bUPYz8NiWWDCvvN3VQwmBl9RK5SAoup8GfZhzefkYLbGfkF6c2WbLHwwf5GE+wzRgNySbXQvr0Op+0XY7VJFVKU72wzFyRYPMbEwan0Xg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609043; c=relaxed/simple;
	bh=yP/78GViKUQZLqschb29oD3kTkqLBYZDWvrc5EIe8gk=;
	h=From:References:To:Content-Type:Cc:Date:Message-Id:Mime-Version:
	 In-Reply-To:Subject; b=Zhlj/uD292+j4niUJ+q6Oy3vT7H87kYpThWtP/ZUL6FmAGfvSLUPHkHau6+zdvJ7aTUWXQZ4F2qT02piYdApa5lQxrLIoog5xDPC/Ig/u5zQ3e/yeW1BCNpDy9uMD3c/a106Bl9GvrndEAYX3BIAoGYbkEpBvDPEdHGlPIaJ3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IQLaUAfX; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IQLaUAfX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1770608941; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=yP/78GViKUQZLqschb29oD3kTkqLBYZDWvrc5EIe8gk=;
 b=IQLaUAfXSt/0WYq08S4WQ5s6qMH/b/fbY+LaVNQzRvR64sOkL8ClLTmRNJey/J9rnG/8b6
 rN2svMgw/0Ypo4iFeEph/lO9R9CiNi4j/uv8PfTjTQbTk2/M8Eiy9cvCoXYPYmLX1CgibL
 jUdceHuEDKpypHAGq0xoIkQlMBuHMzR9Y8ZMaSkGcrGTRo1wCRPOuahUftlTC9qWJBWoBr
 j1XU03qdOBNRNBvIqlpRjrx7YwjF0NMmVWS60px8zkQ/m99Ru3mXMbKn2JXrh8JvzqRBAw
 NW8SJBfXpdlBNtPZXtquYT4l9OtEZbJJNQQxHq0Edz5dBRpRl2/blwm9lJf32w==
From: "Rui Qi" <qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
References: <20260202094200.53735-1-qirui.001@bytedance.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <cyrilbur@tenstorrent.com>, 
	<andybnac@gmail.com>, <debug@rivosinc.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26989592b+9e48ab+vger.kernel.org+qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>
Date: Mon,  9 Feb 2026 11:48:46 +0800
Message-Id: <20260209034846.56639-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260202094200.53735-1-qirui.001@bytedance.com>
Subject: [PATCH v1] riscv: add hardware error trap handler support
X-Original-From: Rui Qi <qirui.001@bytedance.com>

Hi all, could we loop in a few more reviewers to get broader feedback on this series
