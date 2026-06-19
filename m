Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A437B03E;
	Fri, 19 Jun 2026 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868518; cv=none; b=ilovJ/CfPjVEqYeoFuw/ZLgTy+2AY4dtCG8BSkqOSBHJAN1RHD6W1zEH4E2/h6MQTig0LdDEnzpK9P4sV5xW1+7lpxClNO5x25C8tfWLNxwel00Khbom3QF43bdf5sIPKyiGvCzNlOjj9dpDVbS/bMPLAvpW1MKVc+yuahU5LAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868518; c=relaxed/simple;
	bh=wG8vqSZRlfADMw19ZyBJUL9fV/W959NkPCp0oBJpaGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUi4KNep6DdqSURa24Co7/sPicy4Cy/++OZj6ErFyJW4bRU6gLLW+g3JtxcWWUymhhHVxTMjG9NvHT/5wJ6wR3c6FbY9BWkDb5wqybC7VuQ3E6wCVug8czIbV24TUeHdzyx7NgMRVJHPoTC9BJbofjR0cM0Z3e3c3ONYWHYNNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bq1J5b+6; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bq1J5b+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dF
	FX1HkXHLgluOIZ1FYNUEJLqZLrQvqoPtt5ncKjmX0=; b=Bq1J5b+6+H18kgN2Ng
	NC9KkVd1SOW2IIywduRzrSPHJkEyfeEiBAmI7n4yUshKgcrqDAjvPlxs5txpE7/V
	MVNFYGwhazJRDRQy+PfR5qxp2MiGzK5g1cs9MXLk/prRLvOmgnGL7QLpPyPPgt9M
	pE1FPWRBAepH1C9rae/jM7+5Y=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3NKOmJzVqVoGHEg--.21031S2;
	Fri, 19 Jun 2026 19:27:36 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: brauner@kernel.org
Cc: alex.aring@gmail.com,
	allen.lkml@gmail.com,
	arnd@arndb.de,
	chuck.lever@oracle.com,
	ebiederm@xmission.com,
	j.granados@samsung.com,
	jack@suse.cz,
	jackzxcui1989@163.com,
	jlayton@kernel.org,
	keescook@chromium.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core
Date: Fri, 19 Jun 2026 19:27:34 +0800
Message-Id: <20260619112734.3918607-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619-hiervon-kopfsache-rechen-efbdf4463544@brauner>
References: <20260619-hiervon-kopfsache-rechen-efbdf4463544@brauner>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NKOmJzVqVoGHEg--.21031S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFyUWF1DWF15KFyDuw4rZrb_yoW8KFWDpa
	98Ka4IyF4DKFZ7AFs7J3W8Ja4rG34rJr47ur9xu34DA3ZxuF13XFW3tFW5t3Z8Cr4kK3yF
	qFWjq34Uu343taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU79NsUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwnb5Wo1J6nOCAAA3f

On Fri, 19 Jun 2026 09:23:30 +0200 Christian Brauner <brauner@kernel.org> wrote:

> On Thu, Jun 18, 2026 at 11:07:00AM +0800, Xin Zhao wrote:
> > A coredump typically takes some time to complete. If we happen to hold a
> > write lock with flock just before triggering the coredump, that write lock
> > will not be released during the entire coredump process. As a result,
> > other processes attempting to acquire the same write lock may experience
> > significant delays.
> > 
> > To address this, we introduce the F_[GET|SET]FD_EX fcntl operation and the
> > FD_CLOBCOR flag, allowing coredump_wait() to release any file descriptors
> > marked with FD_CLOBCOR. We can also assign the FD_CLOBCOR flag to specific
> > shared memory segments, preventing the coredump from including shared
> > memory that we are not interested in, thereby reducing both the coredump
> > duration and the size of the core file.
> > 
> > We actually considered using signals that generate coredumps to perform
> > the actions we wanted in user space. However, since other threads within
> > the process are not frozen when handling these signals, indiscriminately
> > closing an fd can lead to concurrency issues. For example, if the thread
> > that triggered the coredump closes the fd in the signal handler while
> > other threads are using the resources associated with that fd, it could
> > cause secondary corruption of the coredump state.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> > ---
> 
> Eew, NAK. No way we're doing this.
> I can see a point in filtering memory that one isn't interested in but
> that has to be built on top of the coredump socket protoctol by
> extending it.

Thank you for your suggestion. Now, besides knowing about MADV_DONTDUMP to
filter out uninteresting memory, I also learned about the new method you
mentioned: the coredump socket protocol.

In addition to the need to filter out uninteresting memory during a core
dump, what I really hope to address is the issue of the flock lock being
held for a long time during the core dump process. I have completely
given up on adding a new fcntl interface to solve this problem. In the v2
version I sent, I called exit_files in coredump_wait to address this
issue. Please let me know if you have any comments on my v2 version.
Link: https://lore.kernel.org/lkml/20260619003900.3546571-1-jackzxcui1989@163.com/

Thanks
Xin Zhao

