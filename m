From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/6] Revert "arm64: Remove unnecessary ISBs from set_{pte,
 pmd, pud}"
Date: Wed, 28 Aug 2019 02:29:35 +0000
Message-ID: <20190828022936.A97992173E@mail.kernel.org>
References: <20190827131818.14724-2-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827131818.14724-2-will@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sasha Levin <sashal@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 24fe1b0efad4 arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}.

The bot has tested the following trees: v5.2.10, v4.19.68.

v5.2.10: Build OK!
v4.19.68: Failed to apply! Possible dependencies:
    0795edaf3f1f ("arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

--
Thanks,
Sasha
