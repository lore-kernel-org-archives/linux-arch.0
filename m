Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2C32B99F;
	Mon, 11 May 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778495510; cv=none; b=K3wZEvcnt5AEPeFUXmOJAfj9sMM+nJvk5u/gTFKj+mJuEXHBcnHlACosKLLLdnaeBQwIm4+ZNzY8oKNDgph4sPsjLQUMkkv1ywUK3C3yoPgHb9LLlaFxzPOeQF3V2eziorKPowlHx2HYk6Zl3dG+dTUKjZr8gKiDA35tGU3xXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778495510; c=relaxed/simple;
	bh=G8GKrRRo0B+kDp05yhuHUdnGS1UZ65YJ4Q5wBVwhVqc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aNh+FPSt/ZpWJejFlo0THYrcMP2ZT2c+92a0QBrLi97oqcsbiFJTtc58MnyO4mk1rio8HaQQ/64JVDqbH3ihhC5MGGAZIGOIhp6JmXEip2+br2AcNl2s1MeDsDp19itq1s//0Nr3myeD0+qw9VnAP2DWjFjRoC3PQQBeNQWC/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc/dSoX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc/dSoX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37240C2BCB0;
	Mon, 11 May 2026 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778495510;
	bh=G8GKrRRo0B+kDp05yhuHUdnGS1UZ65YJ4Q5wBVwhVqc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=bc/dSoX3ITQBECMdV3az2T95pQw34yDk/Wx7Y9jrxLw8iVMCCrLMlvnl091KoKu6l
	 H3Ru3ybmZ5uLjiWRM5kUAveEwjoA4T4OamNWzRS93oD9f7mNKxnT3v4c5UC8geOtet
	 J8+FbpmU3zPuFdB2sdk/czzZn6cIaPRA6ajmFNfpzcTrMv2jqwONZeUI0IctjJKSWM
	 1iSV7KZT4d7iYw4K1QN0SbrCvQ/rj/tt0X2woa3JNZ2qox08i4KBIPZHZd3cigOaT+
	 lsjYvxfwLvkFgJk/FkyDmztiM1SxZiDAL90SwtQQACtk36knShnfiso9nGwDPitLNl
	 Jv3FA5pvu5FiA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20260424114611.1678641-2-jkoolstra@xs4all.nl>
References: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
 <20260424114611.1678641-2-jkoolstra@xs4all.nl>
Date: Mon, 11 May 2026 12:31:39 +0200
Message-Id: <177849549986.77176.16709911738228091841.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=576; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G8GKrRRo0B+kDp05yhuHUdnGS1UZ65YJ4Q5wBVwhVqc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxbhDa/pF3b8w2ia1vLooFRntZhLLOVEr8cr6jTaZm7
 v6qdao5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5Ecbwh+Nunwmr9pNb5vce
 lPeoSMW3+rktufu+gPO5m2gdl7i9H8M/HX1hgzcJyy/kqDN4tCqaRt22snFa8v9nL/fnydvXsam
 wAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 24 Apr 2026 13:46:02 +0200, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> To get an operable version of an O_PATH file descriptor, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>"), which
> depends on a functioning procfs.
> 
> This patch adds the O_EMPTYPATH flag to openat(2)/openat2(2). If passed,
> LOOKUP_EMPTY is set at path resolution time.
> 
> [...]

Reviewed-by: Christian Brauner <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
