Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79E4C97;
	Tue, 18 Aug 2026 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787011782; cv=none; b=je+k3jVAoIyN3HewnBBJwi9o2+jORb125OudONJ8KYzsxlX06HmEyVt22sFXzYyZWEzjEEGi7AwJgJZUI/6bS3+b/2F3b1GeLZNgm21egMqVlBbMciMX7AgUBWr7iweoP/j0vqvdUunThxXQ/rDvZ6kE34YPLlmBUtgnDgRjBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787011782; c=relaxed/simple;
	bh=EniMUyFxClAvMEcjrJEoc0SuHyJDtJriurNP857F9Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cNPOwzL2MO3bnaA62tSBzs/7sr7LafNHi0C7zpVHQHhazPgssWBbUyYMUO7VP7Boo7APt2hPlHNIY65nqCGKWUllCpVD6i/rDur7KDk9qq/n2LUBDvMkie09o1pFvMX/00G5YPDmMTV0+j1sRRXREENFPCx29D9lYFLkOLRFQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUlHdB14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUlHdB14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A91D1F000E9;
	Tue, 18 Aug 2026 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787011781;
	bh=NfPE3b+vHnmc06jL+3Uq4lTVP5U+I/WCRiO5cBBheRM=;
	h=From:To:Cc:Subject:Date;
	b=IUlHdB14ipwAPCWPenyPVfpMfhSz2oLggEKFS9gqXcQx0x+5ZEeaiL8Gp4QdLEIhU
	 2Hyb968vhLDa6vRh0mDzVrjhN7VnXm88Fyb391pji7Wm681vmvZj/XYTGXBwAbbEN1
	 z3QgdcDm+QpF2mSQ5YhaEI0EQ8zaZT+h1U9YBVttWveYN0X4REURGmbvXDFDabvjpG
	 gFGyAIac85+QNSURrHG7bHr5JI9DEKjnQxvLzwcuvkbx8Qm8CJtVtCEwtwPwu5cJ91
	 n19kTuIO6WkkPnG8ZDxxrOtX3Yw+iLVq/o+GRI+He01Bj9a7vciA89RXVfWLir/Sm9
	 uGLcI54zMC40w==
From: guoren@kernel.org
To: torvalds@linux-foundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v7.3
Date: Mon, 17 Aug 2026 20:09:27 -0400
Message-Id: <20260818000927.618275-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the updates for csky for v7.3.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-7.3

for you to fetch changes up to abb81e5ce7d995baa41556b8125fa59e28ba3be8:

  csky: Fix a4/a5 restoration in syscall trace path (2026-07-02 17:26:58 -0400)

----------------------------------------------------------------
csky 7.3 Release Notes

 - Fix a4/a5 restoration in syscall trace path

----------------------------------------------------------------
Hanlin Song (1):
      csky: Fix a4/a5 restoration in syscall trace path

 arch/csky/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
