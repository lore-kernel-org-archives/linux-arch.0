Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661172;
	b=IU4n8ZhaVSVMPWB8IywtmcJNsK0QGivafXwYKessWxxFbsoS8FOjvHrQAZlCEB4A4aaY
	 FnspSGRVFnhYyoNbZ9H49b5ZfNZQDMlCsVaTUDB5z/wotGnnowjuQSY3MVdOVyXt5k27b
	 d1s3MCjqCNarATSMzzAzVxNWrUIAqN2mTQL+8oupFbaO+GR9PbjNj41JB3k+DS0E6zqFn
	 /hRL8J4eZmtUg4BFy9tEUsJ5x3556FsA+yCQWygQy+8Fd70YtuyQa0+6RtXgznnYwS95S
	 chZE+7XAJUJxRL3ni5IoUYgvIc3SqpRTsy/zwRwnx1r8s9rMHygqu75pRCKPcXac10g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=IXbWJMQGtd+uEtpM2HfUyLm0yd6US+pC9H9lL0RbBRA=;
	b=h5/2d0r+xhNN2XYjkpoCOesBzF5vKwqzM7C1xljNOXAHX1SD3uA51HMuque852OMYB+V
	 CfpQH/m2XLS4aBQxn4BESxCb3PvPqCzgLsw6EZvrSiuhzrA0F93sDUdjQFi6ojyhgm0lF
	 o17KvsBAJdDzo6xhwb9xw1NwobzGX5aUwm7tNgXXxGEUx9K5bANyBfqX56mei09CDyW9c
	 qJNOn9IWta+BPy1J+u5h/3cltzmmao8ymDmh0ldV9WzgxASTcIkT21Z8cCZ22HA6EjAJA
	 pyQ4/DjS93n7vo6e4jEWIpoa6nq+LhtGVbjU3qtrKrYbyxo5mAqv2YPgRn/V3JoD/1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N3eGPNUd;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C308606A338
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 23:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C308606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N3eGPNUd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67a6b2a2259so2593131d50.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Nov 2026 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793661171; x=1794265971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IXbWJMQGtd+uEtpM2HfUyLm0yd6US+pC9H9lL0RbBRA=;
        b=N3eGPNUdkta531jF+hIrN9rZQYMNpXgSqaoiSxtbqTqp1M8vaipwuj54onFs0KU+bG
         zEgvBSlyw7DBEKLmGNK27GvgC2fPfwCPeFV3tnyrdVCUsWZlSseiWa6EAMD2Pg1acT25
         lcAI4rQoB6uFnuPNhfE7NC+lucIN0Ltd/deV1IHl93RuJ2xPCoNms09+FK8sjqD5mRhP
         Q14Me68IGXOvFD4FJOPwpMVGyiTD+ETr5MzK+Ms/VmjPXRwJfMHrWBjd8lsfH53dFk8p
         r063sYv9hqlaewKwXCNK8j1eoM/N7yGe7X14DvDjkyebhomyZ6TokkTjbjYau+69TAhC
         6OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661171; x=1794265971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXbWJMQGtd+uEtpM2HfUyLm0yd6US+pC9H9lL0RbBRA=;
        b=lpeXXxkhEqiSMCrOU4FO+P5ZGf55NvQ/FML5KtHlaTFuMOiGVZjUjduVdqn6HfUWCu
         OUOEIyDCdKGG7z9xRfrvgNG2blj7xv9aNmU/5SiIMEap6QXGB4A9R1eBUgDuCLb59RF3
         LmwOG8jwu11gfLxJefv3xzPtPhh2rjGft+QyUz6E5hxr7vRpaMiyaDay1cqFDrnMapLx
         6NHOmFuk79OFeU/4IFNkrclCPmWk84JLJE2hu5iheBI6q7A6clE+dgAMJ1PFYRnE7eKJ
         /V6coVVl5mofrl9z4wtikVyiIn4lR6IKceZgvspcyrJ7yVInDnA47BpUzDQlYFtW3OFF
         Yg3A==
X-Forwarded-Encrypted: i=1; AKwUvBwriY3pNyhDK5f7RtHvViy9rFss+PRFI4c+wqNVZSYvOVBUnAvFt8HAG3YM9Rwo3tGjCxYZWd3at+Jz@vger.kernel.org
X-Gm-Message-State: APuU4Z8hvlV2sIuD33PSXiaLzceI9p5us6+syFnmRny9tKjJlgxNl4jc
	k4Yv1JCOpArqW+3ZKAb1T8g+8V1PC6ayiRTJecPr6D5oZ5YL6i3Uv8g80Gr2Ro5vvKbchI3jh4z
	1globUA==
X-Gm-Gg: AYBFou3j/1zae1fqrxpK8NKFRha7qmE66iI7VMz3HM6QIkzm0UX0IjhnadaqnyaNIdU
	XyMVenlqDSlguwrPHUlgvsQxYXb+mPm4+/KrmvMqQ54GOZ0QvWUjc2jQRQfui9gV3ctB7NQjlXL
	jv1KKsEP5TPZK2Yhdp8PDbPsJgQcfj5jO73bQ53jmV9lgyl8spryVHMAgvby6U0RuQ5/+C5GBer
	/azLGyLNGGGyacXMHSSFkUSCet0JQR19sYW208kiSFQ1NA6xhIsDiD1/yd90H+msf1W0SjNUPPC
	ZLsyPSX787f4DpoaEtHakxbx2tajsstVDnMh3voB/Tcj8FBsWP3rp4b4252vOkYnfS7HZr/ksV/
	IEyZu9J0hie+5QqAmrUoMVngWmvLnVtCG3ATVQkpNpw2CeM53RtiUceDdXj7sTyBCUiBPRRiven
	Ds8KfFlhMQDpuSI5Rcwa3oT2g9qc2t9X6aMhJqkyKgjnmIBwY27ZmEnAXiD5K9ABwzEZWv8U5pc
	hGIx1uVHGlK0WehBwnQJw3oesnCcFqI6O91hPd52Ta2yqIQ8VBNr1EqX2WmJZ2S9C541YHI4Eb2
	6K4RjbVctjqPYNhf+fYkr+X6+mj6s1AbC5oq0Aeam//jmTPWqHsJlHtsP9k2Wi6fn1hk6Kev89x
	JBYztKWfBl+5D2vuKt4rr//HGzQwmizM=
X-Received: by 2002:a05:690e:b8a:b0:679:a0b7:2407 with SMTP id 956f58d0204a3-67ba4ee9d50mr6406540d50.40.1793661171164;
        Mon, 02 Nov 2026 15:12:51 -0800 (PST)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3303ebsm5946481d50.18.2026.11.02.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:12:50 -0800 (PST)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 02 Nov 2026 17:12:34 -0600
Subject: [PATCH net-next 1/3] selftests/net: pass socket options to the
 scm_pidfd test flows
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
Message-Id: <20261102-halaney-scm-creds-thread-v1-1-0b4d75dbf35f@amutable.com>
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
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

pidfd_flow() and leader_flow() take booleans that pick between
SO_PASSPIDFD and SO_PASSPIDFD_THREAD. Make them take a zero-terminated
list of socket options for the receiver to enable instead, so tests for
further SO_PASS* options can reuse the same flows rather than copying
them just to muck with options.

Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 69 ++++++++++++-------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index cbe53fab44fc..7524f3f6a8aa 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -765,20 +765,37 @@ static int read_pidfd_msg(int fd, struct pidfd_msg *out)
 	return 0;
 }
 
+/* Zero-terminated lists of SOL_SOCKET options for the receiver to enable */
+static const int pass_tgid[] = { SO_PASSPIDFD, 0 };
+static const int pass_thread[] = { SO_PASSPIDFD_THREAD, 0 };
+static const int pass_both[] = { SO_PASSPIDFD, SO_PASSPIDFD_THREAD, 0 };
+
+static int set_opts(int fd, const int *opts)
+{
+	int on = 1;
+
+	for (; *opts; opts++) {
+		if (setsockopt(fd, SOL_SOCKET, *opts, &on, sizeof(on))) {
+			log_err("Failed to set socket option %d", *opts);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Runs @nwriters threads of one child process against a SOCK_STREAM pair,
- * all of them queued before the parent reads. SO_PASSPIDFD is set when
- * @want_tgid is given, SO_PASSPIDFD_THREAD when @want_thread is. @nread
- * reads are returned in @out.
+ * all of them queued before the parent reads. The receiver enables @opts
+ * first. @nread reads are returned in @out.
  */
-static int pidfd_flow(void *(*sender)(void *), int nwriters, bool want_tgid,
-		      bool want_thread, struct pidfd_msg *out, int nread)
+static int pidfd_flow(void *(*sender)(void *), int nwriters, const int *opts,
+		      struct pidfd_msg *out, int nread)
 {
 	int child_status = 0;
 	int syncpipe[2];
 	int ackpipe[2];
 	int sk[2];
-	int on = 1;
 	char sync;
 	pid_t child;
 	int i;
@@ -807,17 +824,8 @@ static int pidfd_flow(void *(*sender)(void *), int nwriters, bool want_tgid,
 	close(seq_pipe[0]);
 	close(seq_pipe[1]);
 
-	if (want_tgid &&
-	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD");
+	if (set_opts(sk[0], opts))
 		return -1;
-	}
-
-	if (want_thread &&
-	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD_THREAD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD_THREAD");
-		return -1;
-	}
 
 	/* let the child know the options are set, it can write now */
 	if (write(syncpipe[1], "1", 1) != 1)
@@ -897,7 +905,7 @@ TEST(scm_pidfd_stream_glues_threads)
 {
 	struct pidfd_msg msg[1] = { 0 };
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, true, false, msg, 1));
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, pass_tgid, msg, 1));
 	EXPECT_EQ(sizeof(struct thread_ids) * 2, msg[0].len);
 
 	EXPECT_TRUE(msg[0].have_tgid);
@@ -914,7 +922,7 @@ TEST(scm_pidfd_thread_stream_splits_on_threads)
 	struct pidfd_msg msg[2] = { 0 };
 	int i;
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, true, true, msg, 2));
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, pass_both, msg, 2));
 
 	for (i = 0; i < 2; i++) {
 		EXPECT_EQ(sizeof(struct thread_ids), msg[i].len);
@@ -937,29 +945,20 @@ TEST(scm_pidfd_thread_stream_splits_on_threads)
 }
 
 /* Sends from the thread-group leader */
-static int leader_flow(bool want_thread, struct pidfd_msg *out)
+static int leader_flow(const int *opts, struct pidfd_msg *out)
 {
 	struct thread_ids ids = {
 		.pid = getpid(),
 		.tid = gettid(),
 	};
 	int sk[2];
-	int on = 1;
 	int ret;
 
 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk))
 		return -1;
 
-	if (setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD");
+	if (set_opts(sk[0], opts))
 		return -1;
-	}
-
-	if (want_thread &&
-	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD_THREAD, &on, sizeof(on))) {
-		log_err("Failed to set SO_PASSPIDFD_THREAD");
-		return -1;
-	}
 
 	if (send(sk[1], &ids, sizeof(ids), 0) != sizeof(ids)) {
 		log_err("send");
@@ -980,7 +979,7 @@ TEST(scm_pidfd_leader_sender)
 
 	ASSERT_EQ(getpid(), gettid());
 
-	ASSERT_EQ(0, leader_flow(false, &msg));
+	ASSERT_EQ(0, leader_flow(pass_tgid, &msg));
 	ASSERT_TRUE(msg.have_tgid);
 	EXPECT_FALSE(msg.have_thread);
 
@@ -995,7 +994,7 @@ TEST(scm_pidfd_thread_leader_sender)
 
 	ASSERT_EQ(getpid(), gettid());
 
-	ASSERT_EQ(0, leader_flow(true, &msg));
+	ASSERT_EQ(0, leader_flow(pass_both, &msg));
 	ASSERT_TRUE(msg.have_tgid);
 	ASSERT_TRUE(msg.have_thread);
 
@@ -1012,7 +1011,7 @@ TEST(scm_pidfd_thread_and_group)
 {
 	struct pidfd_msg msg = { 0 };
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, true, true, &msg, 1));
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, pass_both, &msg, 1));
 	ASSERT_NE(msg.ids.pid, msg.ids.tid);
 	ASSERT_TRUE(msg.have_tgid);
 	ASSERT_TRUE(msg.have_thread);
@@ -1028,7 +1027,7 @@ TEST(scm_pidfd_thread)
 {
 	struct pidfd_msg msg = { 0 };
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, false, true, &msg, 1));
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, pass_thread, &msg, 1));
 	ASSERT_NE(msg.ids.pid, msg.ids.tid);
 	ASSERT_TRUE(msg.have_thread);
 	EXPECT_FALSE(msg.have_tgid);
@@ -1040,7 +1039,7 @@ TEST(scm_pidfd_thread_group)
 {
 	struct pidfd_msg msg = { 0 };
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, true, false, &msg, 1));
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, pass_tgid, &msg, 1));
 	ASSERT_NE(msg.ids.pid, msg.ids.tid);
 	ASSERT_TRUE(msg.have_tgid);
 	EXPECT_FALSE(msg.have_thread);
@@ -1052,7 +1051,7 @@ TEST(scm_pidfd_thread_creds)
 {
 	struct pidfd_msg msg = { 0 };
 
-	ASSERT_EQ(0, pidfd_flow(send_ids_creds_thread, 1, true, true, &msg, 1));
+	ASSERT_EQ(0, pidfd_flow(send_ids_creds_thread, 1, pass_both, &msg, 1));
 	ASSERT_NE(msg.ids.pid, msg.ids.tid);
 	ASSERT_TRUE(msg.have_tgid);
 	ASSERT_TRUE(msg.have_thread);

-- 
2.56.0

