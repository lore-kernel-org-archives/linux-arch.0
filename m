Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A31C433EF
	for <linux-arch@archiver.kernel.org>; Wed, 16 Mar 2022 22:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiCPWrN (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Mar 2022 18:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiCPWrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 18:47:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699312AF4;
        Wed, 16 Mar 2022 15:45:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h5so2975366plf.7;
        Wed, 16 Mar 2022 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKmb5B2Q982zltr5wM44NyWYgm2l6dW0wJwKVJY05D4=;
        b=ot7ZOXTTt0XmRMAgB71d5CNtjbJbUvl5ebdEQkXxSuNK1jfYIx+GVKbsoLGN+d7pZW
         f+fY/j2PMF/+VGA69pb8m+E91NVQvWw0RESifISvqgCMDxQ8+hKKVYx6Ty09dvx8t8o7
         amAVFs+9dCrdNSb9EMmHlqB7iBlpsR96rIO6ZX/wx+5VT9CQQFwjDkEk3XLjD/2Jfz2w
         /knRrZ/sz7nBtX8LPvuOTbvvILwkNRfYlgoRPilmGOEZ/CGfHzD55zDHu7K+ylX+bIpW
         BkFxBlJDY5lG8uCtwBQujhsq4QcoJ8y6mkBnYy9ZYxB67NfK+7uDfzvI2gWAE7YfFed1
         EeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TKmb5B2Q982zltr5wM44NyWYgm2l6dW0wJwKVJY05D4=;
        b=z5R0P/9I5725kHprLMWHY4ouv/ur/kOqp0bxKrCHv1DNRqfZXq1nW91Lc2kGTmZF8x
         hWRCQeY3eahCqDiIuAZ9IeRXL8Wso0vgGZ1cAdptbBb4ZXdbgexzp3S9DkcVovJIAr3L
         l+isqzDZWlz3v7mvrbuXH/9YJtLeWzyO1aIQh1i6LOIwdL9l493pNFrv5rzNbYB1VVzf
         Zrm5yDS6Q3O7ZSHz3hM/61t8r+PeBZBvIlOmsOEPy3XOXS9ZJ7NdGDcCDUsfzU0S8qMF
         gO5esDkl/N6U7EiFEKLvYIJuSyvsY0azxElYoE9UNMSIuNH+vmh8Vo8VPklAlaYnSvTs
         LtnQ==
X-Gm-Message-State: AOAM5331u2Yk1LZH6xTaJEEn+wdoeivXIGYQBZWXPpanC8GHz9JcB8GO
        T1eKulzNAr4E75Dy83cm1/g=
X-Google-Smtp-Source: ABdhPJyni/5MZlv62k8vIOBzsIxMXx2VM7kKfkxXy7/8/WMPzrFBg20dFUt7E9ckAGxx6uGE6kt1PA==
X-Received: by 2002:a17:902:ba84:b0:153:9866:ff54 with SMTP id k4-20020a170902ba8400b001539866ff54mr2095609pls.126.1647470756925;
        Wed, 16 Mar 2022 15:45:56 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:9b43:96ac:9f9:5093])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a088d00b001c64d30fa8bsm6397832pjc.1.2022.03.16.15.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 15:45:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/2] locking: Add new lock contention tracepoints (v3)
Date:   Wed, 16 Mar 2022 15:45:46 -0700
Message-Id: <20220316224548.500123-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

There have been some requests for low-overhead kernel lock contention
monitoring.  The kernel has CONFIG_LOCK_STAT to provide such an infra
either via /proc/lock_stat or tracepoints directly.

However it's not light-weight and hard to be used in production.  So
I'm trying to add new tracepoints for lock contention and using them
as a base to build a new monitoring system.

* Changes in v3
 - move the tracepoints deeper in the slow path
 - remove the caller ip
 - don't use task state in the flags

* Changes in v2
 - do not use lockdep infrastructure
 - add flags argument to lock:contention_begin tracepoint

I added a flags argument in the contention_begin to classify locks in
question.  It can tell whether it's a spinlock, reader-writer lock or
a mutex.  With stacktrace, users can identify which lock is contended.

The patch 01 added the tracepoints and move the definition to the
mutex.c file so that it can see the tracepoints without lockdep.

The patch 02 actually installs the tracepoints in the locking code.
To minimize the overhead, they were added in the slow path of the code
separately.  As spinlocks are defined in the arch headers, I couldn't
handle them all.  I've just added it to generic queued spinlock and
rwlocks only.  Each arch can add the tracepoints later.

This series base on the current tip/locking/core and you get it from
'locking/tracepoint-v3' branch in my tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (2):
  locking: Add lock contention tracepoints
  locking: Apply contention tracepoints in the slow path

 include/trace/events/lock.h   | 54 +++++++++++++++++++++++++++++++++--
 kernel/locking/lockdep.c      |  1 -
 kernel/locking/mutex.c        |  6 ++++
 kernel/locking/percpu-rwsem.c |  3 ++
 kernel/locking/qrwlock.c      |  9 ++++++
 kernel/locking/qspinlock.c    |  5 ++++
 kernel/locking/rtmutex.c      | 11 +++++++
 kernel/locking/rwbase_rt.c    |  3 ++
 kernel/locking/rwsem.c        |  9 ++++++
 kernel/locking/semaphore.c    | 14 ++++++++-
 10 files changed, 110 insertions(+), 5 deletions(-)


base-commit: cd27ccfc727e99352321c0c75012ab9c5a90321e
-- 
2.35.1.894.gb6a874cedc-goog

