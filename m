Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9322F388;
	Thu, 18 Jun 2026 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763863; cv=none; b=FN490JIPsr9XZLQG/ABZIrkuQGwsd6lLtfR4MEIpKWapNp7Qt7K8eSleCCurdXEDAem7GbBn9hUxLfoGksjt9R7b9ZU9OFrZJi7KlZ/rKF2WYk+RwmN9gf7XJ+0sRiKxCa9dm6Ime/8IKabiUXJ3nEaCnt2OoTDNbC0SxRZsH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763863; c=relaxed/simple;
	bh=t54MeqHUPYhrOSafz/tHUAIX5VsY2HuU53W5vyxoid8=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=RgyXaDhyd+gJlv9Ei0yAhfxx2bWnO6LdhT4spxD4Xvp2o2L0sJHTMHcR1fS4jLNh/GvW9u45BL3i4FUTn0gAaBJmWmv+A4I+8f6nrkH5mtqQQQPSaA0aEyNZUgYUfp2in6WNLq1p7U2RZz3JsGVf2u0InwDPu6wJ1rp9TFSjZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=pEyuhzRm; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="pEyuhzRm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=t54MeqHUPYhrOSafz/tHUAIX5VsY2HuU53W5vyxoid8=; b=pEyuhzRmQTz+GUUhEKkXMnM9j5
	XXeIT9ngrhd0SqI1ZcwBc6JdQ69PY7PZ/3icv+nJhMBVVvJ0i8zCY8aCySSEyl55TX9dTh+Eut0en
	mB0mb5RM1+y0Jdt21KKCYJEA235ZHam0BhBNIK4R5BBqYIV6BRy9+puCZj4IMjYjldWc=;
Received: from in02.mta.xmission.com ([166.70.13.52]:54906)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wa5KG-006itu-91; Wed, 17 Jun 2026 23:30:04 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:41524 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wa5KF-004eoV-GR; Wed, 17 Jun 2026 23:30:03 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  jlayton@kernel.org,  chuck.lever@oracle.com,  alex.aring@gmail.com,
  arnd@arndb.de,  keescook@chromium.org,  mcgrof@kernel.org,
  j.granados@samsung.com,  allen.lkml@gmail.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org
In-Reply-To: <20260618030700.2511668-1-jackzxcui1989@163.com> (Xin Zhao's
	message of "Thu, 18 Jun 2026 11:07:00 +0800")
References: <20260618030700.2511668-1-jackzxcui1989@163.com>
Date: Thu, 18 Jun 2026 00:29:57 -0500
Message-ID: <87zf0se7qi.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wa5KF-004eoV-GR;;;mid=<87zf0se7qi.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/yZfePfs7NEwStx/dsBnYnG891qiE7A3Q=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4035]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Xin Zhao <jackzxcui1989@163.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 10 (3.2%), b_tie_ro: 9 (2.8%), parse: 0.73 (0.2%),
	 extract_message_metadata: 2.6 (0.8%), get_uri_detail_list: 0.95
	(0.3%), tests_pri_-2000: 2.8 (0.9%), tests_pri_-1000: 1.98 (0.6%),
	tests_pri_-950: 1.02 (0.3%), tests_pri_-900: 0.80 (0.3%),
	tests_pri_-90: 57 (18.1%), check_bayes: 55 (17.8%), b_tokenize: 5
	(1.6%), b_tok_get_all: 7 (2.3%), b_comp_prob: 1.96 (0.6%),
	b_tok_touch_all: 38 (12.3%), b_finish: 0.69 (0.2%), tests_pri_0: 219
	(70.0%), check_dkim_signature: 0.44 (0.1%), check_dkim_adsp: 2.3
	(0.7%), poll_dns_idle: 0.66 (0.2%), tests_pri_10: 1.75 (0.6%),
	tests_pri_500: 9 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before
 dumping core
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, allen.lkml@gmail.com, j.granados@samsung.com, mcgrof@kernel.org, keescook@chromium.org, arnd@arndb.de, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, jackzxcui1989@163.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Xin Zhao <jackzxcui1989@163.com> writes:

> A coredump typically takes some time to complete. If we happen to hold a
> write lock with flock just before triggering the coredump, that write lock
> will not be released during the entire coredump process. As a result,
> other processes attempting to acquire the same write lock may experience
> significant delays.

You are talking about giant processes writing to slow backing store?

I suspect you would be better off quickly writing the coredump to a pipe,
and then writing it to disk.

Unless your machine is badly balanced that should take perhaps a second.

That said I don't see why you need elaborate machinery to do something
about these file descriptors.  Unless I am mistaken no file descriptors
are placed into a coredump.  In which case it should be possible to just
call exit_files early.

> To address this, we introduce the F_[GET|SET]FD_EX fcntl operation and the
> FD_CLOBCOR flag, allowing coredump_wait() to release any file descriptors
> marked with FD_CLOBCOR. We can also assign the FD_CLOBCOR flag to specific
> shared memory segments, preventing the coredump from including shared
> memory that we are not interested in, thereby reducing both the coredump
> duration and the size of the core file.

Please look at vma_dump_size.  There are plenty of ways already to
skip dumping a memory area.  Using file backed shared memory,
and madvise(MADV_DONTDUMP) are two easy ones that already exist.

My point is that there are cleaner ways to solve your problem than
the solutions you have proposed.

Eric
